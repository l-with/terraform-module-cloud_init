  # cluster ips
  - rm --force ${vault_cluster_ips_full_path}
  - touch ${vault_cluster_ips_full_path}
%{ if vault_raft_retry_auto_join != "" ~}
  - >
    discover -q addrs "${vault_raft_retry_auto_join}" | tr ' '  '\n' >>${vault_cluster_ips_full_path}
%{ endif ~}
%{ for vault_storage_raft_cluster_member in jsondecode(jsonencoded_vault_storage_raft_cluster_members) ~}
  - echo ${vault_storage_raft_cluster_member} >>${vault_cluster_ips_full_path}
%{ endfor ~}