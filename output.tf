output "cloud_init" {
  description = "the cloud-init user data"
  value       = local.cloud_init
  sensitive   = true
}

output "vault" {
  description = "the relevant results from vault install and init"
  value = {
    vault_key_shares                     = var.vault_key_shares
    vault_key_threshold                  = var.vault_key_threshold
    vault_init_json_enc_full_path        = local.vault_init_json_enc_full_path,
    vault_init_json_enc_base64_full_path = local.vault_init_json_enc_base64_full_path,
  }
}
