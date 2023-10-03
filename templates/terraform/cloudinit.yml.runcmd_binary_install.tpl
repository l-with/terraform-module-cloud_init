  # binary install
  - >
    curl --remote-name --location https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip
  - unzip terraform_${terraform_version}_linux_amd64.zip
  - mv terraform /usr/local/bin
  - rm --force terraform_${terraform_version}_linux_amd64.zip
