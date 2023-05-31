- path: /etc/systemd/system/docker-${name}.service
  content: |
    [Unit]
    Description=${description}
    Requires=docker.service
    After=docker.service

    [Service]
    Restart=always
    ExecStart=/usr/bin/docker run --restart ${restart_policy} --publish ${ports} --name ${name} ${image} ${command}
    ExecStop=/usr/bin/docker stop ${name}

    [Install]
    WantedBy=multi-user.target
  permissions: '0644'
