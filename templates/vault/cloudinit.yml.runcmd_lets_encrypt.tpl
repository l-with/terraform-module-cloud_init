  - |
    if [ -d /etc/letsencrypt ]; then
      chown vault:vault /etc/letsencrypt -R
    fi
