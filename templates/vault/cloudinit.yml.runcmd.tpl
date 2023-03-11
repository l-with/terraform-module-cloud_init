  - export VAULT_PACKAGE=vault_${vault_version}_linux_$(uname -m).zip
  - >
    curl --remote-name https://releases.hashicorp.com/vault/${vault_version}/$VAULT_PACKAGE
  - unzip $VAULT_PACKAGE
  - chmod + x vault
  - mv vault /usr/local/bin
  - rm $VAULT_PACKAGE
