  - |
    export ipv4_public_address=$(ip route get 8.8.8.8 | grep 8.8.8.8 | cut -d ' ' -f 3)
  - envsubst < ${haproxy_template_path}/haproxy.cfg > /etc/haproxy/haproxy.cfg
