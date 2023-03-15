  - export SECRET=${secret}
  - >
    curl --silent --header "${api_header}" "${url}" | openssl enc -aes-256-cbc -pbkdf2 -d -pass env:SECRET | tar xzC /%{ if post_cmd != "" }
  - ${post_cmd}%{ endif }
