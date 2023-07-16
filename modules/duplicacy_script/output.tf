output "vars" {
  description = "list of var maps for templating write file for init, backup, prune, restore"
  value       = local.vars
}

output "pre_post_scripts_vars" {
  description = "list of var maps for templating write file fpr pre and post scripts"
  value       = local.pre_post_script_vars
}