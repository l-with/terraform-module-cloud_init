  - export SECRET=${secret}
  - >
    curl  --no-progress-meter --output ${name}.enc --header "${api_header}" "${url}"
  - ls -n ${name}.enc
  - >
    openssl enc -aes-256-cbc -pbkdf2 -d -pass env:SECRET -in ${name}.enc -out ${name}
  - ls -n ${name}
  - tar --extract --gunzip --file=${name} --directory=/
  - rm --force ${name} ${name}.enc
%{ if post_cmd != null ~}
  - ${post_cmd}
%{ endif ~}
