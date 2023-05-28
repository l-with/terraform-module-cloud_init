  - |
    export interface=$(ifconfig | grep --before-context=1 ${lnxrouter_ip_address} | grep --only-matching "^\w*")
  - envsubst < ${lnxrouter_service_template_path}/lnxrouter.service > /etc/systemd/system/lnxrouter.service

