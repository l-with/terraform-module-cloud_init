- path: /etc/systemd/system/multi-user.target.wants/vault.service
  content: |
    [Unit]
    Description="HashiCorp Vault - A tool for managing secrets"
    Documentation=https://www.vaultproject.io/docs/
    Requires=network-online.target
    After=network-online.target
    ConditionFileNotEmpty=${vault_config_path}/vault.hcl
    StartLimitIntervalSec=60
    StartLimitBurst=3

    [Service]
    EnvironmentFile=${vault_config_path}/vault.env
    User=vault
    Group=vault
    ProtectSystem=full
    ProtectHome=read-only
    PrivateTmp=yes
    PrivateDevices=yes
    SecureBits=keep-caps
    AmbientCapabilities=CAP_IPC_LOCK
    CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
    NoNewPrivileges=yes
    ExecStart=${vault_binary_path}/vault server -config=${vault_config_path}/vault.hcl
    ExecReload=/bin/kill --signal HUP $MAINPID
    KillMode=process
    KillSignal=SIGINT
    Restart=on-failure
    RestartSec=5
    TimeoutStopSec=30
    LimitCORE=0
    LimitNOFILE=65536
    LimitMEMLOCK=infinity

    [Install]
    WantedBy=multi-user.target
  permissions: '0644'
