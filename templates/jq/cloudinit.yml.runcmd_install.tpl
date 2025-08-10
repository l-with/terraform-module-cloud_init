  - >
    curl --no-progress-meter --fail-with-body --remove-on-error --remote-name --location https://github.com/jqlang/jq/releases/download/jq-${jq_version}/jq-linux64
  - mv jq-linux64 jq
  - chmod +x jq
  - mv jq /usr/local/bin
