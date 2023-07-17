%{ for certbot_dns_plugin in jsondecode(certbot_dns_plugins) ~}
  - pip3 install ${certbot_dns_plugin}
%{ endfor ~}
