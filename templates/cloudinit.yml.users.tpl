  - name: ${name}
%{ if groups != null ~}
    groups: ${groups}
%{ endif ~}
%{ if sudo != null ~}
    sudo: ${sudo}
%{ endif ~}
%{ if length(jsondecode(jsonencoded_ssh_authorized_keys)) > 0 ~}
    ssh_authorized_keys:
%{ for ssh_authorized_key in jsondecode(jsonencoded_ssh_authorized_keys) ~}
      - ${ssh_authorized_key}
%{ endfor ~}
%{ endif ~}
%{ if lock_passwd != null ~}
    lock_passwd: ${lock_passwd}
%{ endif ~}