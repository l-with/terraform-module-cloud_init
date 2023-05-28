- path: ${lnxrouter_service_template_path}/lnxrouter.service
  content: |
    [Unit]
    Description="Linux-router"
    Documentation=https://garywill.github.io/proj-doc/linux-router/en/
    Requires=network-online.target
    After=network-online.target
    StartLimitIntervalSec=60
    StartLimitBurst=3

    [Service]
    User=vault
    Group=vault
    ProtectSystem=yes
    ProtectHome=read-only
    PrivateTmp=yes
    PrivateDevices=yes
    NoNewPrivileges=yes
    ExecStart=${lnxrouter_binary_path}/lnxrouter ${lnxrouter_arguments}
    KillSignal=SIGINT
    Restart=on-failure
    RestartSec=10
    TimeoutStopSec=30
    StandardOutput=syslog
    StandardError=syslog
    SyslogIdentifier=lnxrouter

    [Install]
    WantedBy=multi-user.target
  permissions: '0644'
