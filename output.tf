output "cloud_init" {
  description = "the cloud-init user data"
  value       = local.cloud_init
  sensitive   = true
}

output "vault_init_json_tgz_enc_full_path" {
  description = "the full path of the encrypted output of vault init"
  value       = local.vault_init_json_tgz_enc_full_path
}

output "vault_init_json_tgz_enc_base64_full_path" {
  description = "the full path of the encrypted ans base64 encoded output of vault init"
  value       = local.vault_init_json_tgz_enc_base64_full_path
}
