  - mkdir -p ${vault_storage_raft_path}
  - chown vault:vault ${vault_storage_raft_path} -R
  - |
    ip addr show | grep 'inet ' | grep 'scope global' | awk '{print $2}' | cut -d/ -f1 >/root/ip