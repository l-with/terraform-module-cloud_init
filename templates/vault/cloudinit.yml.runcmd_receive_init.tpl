  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep 0' 'ls ${vault_init_json_full_path}; echo $?'
