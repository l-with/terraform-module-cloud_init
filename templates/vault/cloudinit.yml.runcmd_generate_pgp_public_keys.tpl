%{ for i in range(parseint(vault_num_internal_unseal_keys, 10)) ~}
  - gpg --batch --generate-key ${vault_bootstrap_files_path}/gpg_key${i}.conf
  - gpg --armor --output ${vault_bootstrap_files_path}/vault${i}.pub --export vault${i}
  - gpg --armor --export-options backup --output ${vault_bootstrap_files_path}/vault${i} --export-secret-keys vault${i}
%{ endfor ~}
