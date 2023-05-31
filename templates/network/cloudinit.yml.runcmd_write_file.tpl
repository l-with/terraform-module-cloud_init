  - mkdir -p ${write_file_directory}
  - echo ${base64encode(write_file_content)} | base64 --decode >/temp/${write_file_name}
  - |
    export public_interface=$(ip route get 8.8.8.8 | grep 8.8.8.8 | cut -d ' ' -f 5)
  - envsubst < /temp/${write_file_name} > ${write_file_directory}/${write_file_name}
  - chmod ${write_file_mode} ${write_file_directory}/${write_file_name}
