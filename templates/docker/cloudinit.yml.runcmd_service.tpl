  # service
  - systemctl daemon-reload
  - systemctl enable docker.socket
  - systemctl enable docker.service
  - systemctl start docker.socket
  - systemctl start docker.service
