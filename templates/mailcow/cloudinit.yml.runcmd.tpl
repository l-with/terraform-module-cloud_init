  - cd ${mailcow_install_path}
  - docker compose up -d
  - >
    wait_until --delay 30 --retries 60 --check 'grep -e 200' \
      'curl --silent --no-progress-meter --connect-timeout 10 --retry 60 --retry-delay 30 --write-out "%%{http_code}" --insecure https://${mailcow_hostname}'",
  - >
    wait_until --delay 30 --retries 60 --check 'grep -e 200' \
      'curl --silent --no-progress-meter --connect-timeout 10 --retry 60 --retry-delay 30 --write-out "%%{http_code}" --insecure https://${mailcow_hostname}/api/#/'",
