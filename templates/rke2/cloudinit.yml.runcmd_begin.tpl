  - export RKE2_CERT_PACKAGE_SECRET=${rke2_cert_package_secret}
  - >
    curl --silent --header "PRIVATE-TOKEN: ${rke2_cert_package_api_token}" "${rke2_cert_package_url}/${rke2_cert_artifact}" | openssl enc -aes-256-cbc -pbkdf2 -d -pass env:RKE2_CERT_PACKAGE_SECRET | tar xzC /
  - export RKE2_CONFIG_DIR=/etc/rancher/rke2
  - mkdir --parent $RKE2_CONFIG_DIR
  - export RKE2_CONFIG=$RKE2_CONFIG_DIR/config.yaml
  - export RKE2_MASTER1=${rke2_master1_ip}
  - export RKE2_PRE_SHARED_SECRET=${rke2_pre_shared_secret}
  - envsubst < ${rke2_config_template} > $RKE2_CONFIG
  - >
    echo "cni: cilium" >>$RKE2_CONFIG
