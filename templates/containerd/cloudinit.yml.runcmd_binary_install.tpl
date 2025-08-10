  # binary install
  - >
    curl --no-progress-meter --fail-with-body --remove-on-error --remote-name --location https://github.com/containerd/containerd/releases/download/v${containerd_version}/containerd-${containerd_version}-linux-amd64.tar.gz
  - tar Cxzvf /usr/local containerd-${containerd_version}-linux-amd64.tar.gz
