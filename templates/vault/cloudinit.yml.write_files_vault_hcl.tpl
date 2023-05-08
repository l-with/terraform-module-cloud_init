- path: ${vault_config_path}/vault.hcl
  content: |
    ui = ${vault_ui}
    log_level = "${vault_log_level}"
    api_addr = "${vault_api_addr}"
    cluster_addr = "${vault_cluster_addr}"

    %{ for vault_listener in jsondecode(vault_listeners) }
    listener "tcp" {
        address = "${vault_listener.address}"
    %{ if vault_listener.cluster_address != null }
        cluster_address = "${vault_listener.cluster_address}"
    %{ endif }
        tls_disable = ${vault_listener.tls_disable}
    %{ if !vault_listener.tls_disable }
        tls_cert_file = "${vault_listener.tls_cert_file}"
        tls_key_file = "${vault_listener.tls_key_file}"
    %{ endif }
    %{ if vault_listener.tls_client_ca_file != null }
        tls_client_ca_file = "${vault_listener.tls_client_ca_file}"
    %{ endif }
    }
    %{ endfor }

    storage "raft" {
        path    = "${vault_storage_raft_path}"
        node_id = "${vault_storage_raft_node_id}"
    %{ for vault_instance in jsondecode(vault_storage_raft_cluster_members) }
        retry_join {
            leader_api_addr         = "https://${vault_instance}:${vault_storage_raft_retry_join_api_port}"
            leader_ca_cert_file     = "${vault_storage_raft_leader_ca_cert_file}"
            leader_client_cert_file = "${vault_storage_raft_leader_client_cert_file}"
            leader_client_key_file  = "${vault_storage_raft_leader_client_key_file}"
    %{ if vault_raft_leader_tls_servername != "" }
            leader_tls_servername = "${vault_raft_leader_tls_servername}"
    %{ endif }
        }
    %{ endfor }
    }

    disable_mlock = ${vault_disable_mlock}
  permissions: 0644
