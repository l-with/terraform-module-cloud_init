- path: /etc/cron.d/terraform_cloud_init_certbot_renewal
  content: |
    ${certbot_automatic_renewal_cron} root ${certbot_automatic_renewal_cronjob}
  permissions: '0644'
