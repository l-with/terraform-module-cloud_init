  # secure init
  - openssl pkeyutl -encrypt -pubin -inkey ${vault_init_public_key_full_path} -in ${vault_init_json_full_path} -out ${vault_init_json_enc_full_path}
  - chmod ${vault_init_json_file_mode} ${vault_init_json_enc_full_path}
  - base64 ${vault_init_json_enc_full_path} >${vault_init_json_enc_base64_full_path}
  - chmod ${vault_init_json_file_mode} ${vault_init_json_enc_base64_full_path}
  - rm --force ${vault_init_json_enc_full_path}
%{if vault_remove_vault_init_json != null ~}
  - rm --force ${vault_init_json_full_path}
%{ endif ~}
