  - mkdir -p ${write_file_directory}
  - echo ${base64encode(write_file_content)} | base64 --decode >/tmp/${write_file_name}
  - |
    export ipv4_public_address=$(ip route get 8.8.8.8 | grep 8.8.8.8 | cut -d ' ' -f 3)
  - envsubst < /tmp/${write_file_name} > ${write_file_directory}/${write_file_name}
  - chmod ${write_file_mode} ${write_file_directory}/${write_file_name}
