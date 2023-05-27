- path: /etc/haproxy/haproxy.cfg
  content: |
    ${haproxy_configuration}
  permissions: '0644'
