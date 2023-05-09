  - mkdir -p ${vault_storage_raft_path}
  - chown vault:vault ${vault_storage_raft_path} -R
  - |
    ip addr show | grep 'inet ' | grep 'scope global' | cut -d ' ' -f6 | cut -d '/' -f 1
