  - mkdir --parents ${duplicacy_path}/bin
  - >
    curl --output ${duplicacy_path}/bin/duplicacy --location https://github.com/gilbertchen/duplicacy/releases/download/v${duplicacy_version}/duplicacy_linux_x64_${duplicacy_version}
  - chmod +x ${duplicacy_path}/bin/duplicacy
