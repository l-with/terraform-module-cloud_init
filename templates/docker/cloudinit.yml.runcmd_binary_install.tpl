  # binary install
  - >
    curl --no-progress-meter --fail-with-body --remove-on-error --remote-name --location https://download.docker.com/linux/static/stable/x86_64/docker-${docker_version}.tgz
  - tar xzvf docker-${docker_version}.tgz
  - sudo cp docker/* /usr/bin/
  - groupadd docker
