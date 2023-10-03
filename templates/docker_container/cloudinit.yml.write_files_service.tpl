- path: /etc/systemd/system/docker-${name}.service
  content: |
    [Unit]
    Description=${description}
    Requires=docker.service
    After=docker.service

    [Service]
%{ for key, value in jsondecode(environment) ~}
    Environment="${key}=${value}"
%{ endfor ~}
    Restart=always
    ExecStartPre=-/usr/bin/docker stop ${name}
    ExecStartPre=-/usr/bin/docker rm ${name}
    ExecStart=/usr/bin/docker run --rm %{ if ports != null ~}--publish ${ports} %{ endif }--name ${name} ${image} ${command}
    ExecStop=/usr/bin/docker stop ${name}

    [Install]
    WantedBy=multi-user.target
  permissions: '0644'
