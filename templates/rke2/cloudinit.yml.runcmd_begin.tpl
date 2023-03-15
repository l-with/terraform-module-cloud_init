  - export RKE2_CONFIG_DIR=/etc/rancher/rke2
  - mkdir --parent $RKE2_CONFIG_DIR
  - export RKE2_CONFIG=$RKE2_CONFIG_DIR/config.yaml
  - export RKE2_NODE_1ST=${rke2_node_1st_ip}
  - export RKE2_PRE_SHARED_SECRET=${rke2_pre_shared_secret}
  - envsubst < ${rke2_config_template} > $RKE2_CONFIG
  - >
    echo "cni: cilium" >>$RKE2_CONFIG
