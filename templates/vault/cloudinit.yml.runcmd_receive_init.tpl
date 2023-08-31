  # receive init
  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep 0' 'ls ${vault_init_json_full_path} %{ if vault_init_with_pgp_keys ~}${join(" ", jsondecode(jsonencoded_vault_pgp_priv_keys))}%{ endif }; echo $?'
%{ if vault_init_with_pgp_keys ~}%{ for vault_pgp_priv_key in jsondecode(jsonencoded_vault_pgp_priv_keys) ~}
  - gpg --import-options restore --import ${vault_pgp_priv_key}
%{ endfor }%{ endif ~}
