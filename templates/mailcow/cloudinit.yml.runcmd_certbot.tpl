  - cp /etc/letsencrypt/live/${mailcow_hostname}/fullchain.pem /opt/mailcow-dockerized/data/assets/ssl/cert.pem
  - cp /etc/letsencrypt/live/${mailcow_hostname}/privkey.pem /opt/mailcow-dockerized/data/assets/ssl/key.pem
