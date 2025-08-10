  - export SECRET=${secret}
  - >
    curl --fail-with-body --remove-on-error --no-progress-meter --output ${name}.enc --header "${api_header}" "${url}"
  - >
    openssl enc -aes-256-cbc -pbkdf2 -d -pass env:SECRET -in ${name}.enc -out ${name}
  - tar --extract --gunzip --file=${name} --directory=/
  - rm --force ${name} ${name}.enc
%{ if post_cmd != null ~}
  - ${post_cmd}
%{ endif ~}
