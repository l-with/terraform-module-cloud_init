- path: /etc/fail2ban/jail.d/10-${jail}.local
  content: |
    [${jail}]
    enabled = true
  permissions: 0644
