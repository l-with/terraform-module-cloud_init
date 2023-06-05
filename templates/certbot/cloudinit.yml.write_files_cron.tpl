- path: /etc/cron.d/certbot
  content: |
    ${certbot_automatic_renewal_cron} root ${certbot_automatic_renewal_cronjob}
  permissions: '0644'
