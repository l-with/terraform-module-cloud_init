  # service
  - chown vault:vault
  - systemctl daemon-reload
  - systemctl enable vault
  - systemctl start vault
  - >
    wait_until --verbose --delay 10 --retries 42 \
      --check 'grep "Active: active (running)" | wc -l | grep 1' 'systemctl status vault --no-pager'
