- path: /etc/fail2ban/jail.local
  content: |
    [DEFAULT]
    ignoreip = 127.0.0.1/8
    bantime = 10m
    findtime = 10m
    maxretry = 6
  permissions: '0644'
