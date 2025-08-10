  # lets encrypt
  - |
    if [ -d /etc/letsencrypt ]; then
      chown caddy:caddy /etc/letsencrypt -R
    fi
