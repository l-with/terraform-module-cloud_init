output "packages" {
  description = "the cloud-init packages parts"
  value       = local.packages
}

output "write_files" {
  description = "the cloud-init write_files parts"
  value       = local.write_files
}

output "runcmd" {
  description = "the cloud-init runcmd parts"
  value       = local.rundcmd
}