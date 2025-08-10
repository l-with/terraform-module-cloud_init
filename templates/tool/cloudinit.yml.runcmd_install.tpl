  # install
  - >
    curl --no-progress-meter --fail-with-body --remove-on-error ${tool_url} --output ${tool_name}
  - chmod +x ${tool_name}
  - mv ${tool_name} ${tool_dest_path}
