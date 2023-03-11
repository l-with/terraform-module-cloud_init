  - export RKE2_SERVER_MANIFEST_DIR=/var/lib/rancher/rke2/server/manifests
  - mkdir --parent $RKE2_SERVER_MANIFEST_DIR
  - export CERT_MANAGER_CRDS_YAML=cert-manager.crds.yaml
  - curl --remote-name https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/$CERT_MANAGER_CRDS_YAML
  - mv $CERT_MANAGER_CRDS_YAML $RKE2_SERVER_MANIFEST_DIR