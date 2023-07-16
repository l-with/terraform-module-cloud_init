  - mkdir -p ${mailcow_install_path}
  - cd ${mailcow_install_path}
  - git clone --branch ${mailcow_version} --single-branch https://github.com/mailcow/mailcow-dockerized.git ${mailcow_install_path}
  - export MAILCOW_HOSTNAME=${mailcow_hostname}
  - export MAILCOW_BRANCH=${mailcow_branch}
  - export MAILCOW_TZ=${mailcow_timezone}
  - ./generate_config.sh
  - cp --preserve '${mailcow_install_path}/mailcow.conf' '${mailcow_install_path}/mailcow.conf.orig'
  - cp --preserve '${mailcow_install_path}/docker-compose.yml' '${mailcow_install_path}/docker-compose.yml.orig'
%{ if mailcow_docker_compose_project_name != null ~}
  - lineinfile --regexp 'COMPOSE_PROJECT_NAME=' --line 'COMPOSE_PROJECT_NAME=${mailcow_docker_compose_project_name}' '${mailcow_install_path}/mailcow.conf'
%{ endif ~}
%{ if mailcow_api_key != null ~}
  - lineinfile --insertafter '#API_KEY=' --line 'API_KEY=${mailcow_api_key}' '${mailcow_install_path}/mailcow.conf'
%{ endif ~}
%{ if mailcow_api_key_read_only != null ~}
  - lineinfile --insertafter '#API_KEY_READ_ONLY=' --line 'API_KEY_READ_ONLY=${mailcow_api_key_read_only}' '${mailcow_install_path}/mailcow.conf'
%{ endif ~}
%{ if mailcow_api_allow_from != null ~}
  - lineinfile --insertafter '#API_ALLOW_FROM=' --line 'API_ALLOW_FROM=${mailcow_api_allow_from}' '${mailcow_install_path}/mailcow.conf'
%{ endif ~}
%{ if mailcow_submission_port != null ~}
  - lineinfile --regexp 'SUBMISSION_PORT=' --line 'SUBMISSION_PORT=${mailcow_submission_port}' '${mailcow_install_path}/mailcow.conf'
  - lineinfile --regexp '- SUBMISSION_PORT=$${SUBMISSION_PORT:-\d+}' --line '        - SUBMISSION_PORT=$${SUBMISSION_PORT:-${mailcow_submission_port}}' '${mailcow_install_path}/docker-compose.yml'
  - lineinfile --regexp '- "$${SUBMISSION_PORT:-\d+}:\d+"' --line '        - \"$${SUBMISSION_PORT:-${mailcow_submission_port}}:${mailcow_submission_port}\"' '${mailcow_install_path}/mailcow.conf'
%{ endif ~}
%{ if mailcow_additional_san != null ~}
  - lineinfile --regexp 'ADDITIONAL_SAN=' --line 'ADDITIONAL_SAN=${mailcow_additional_san}' '${mailcow_install_path}/mailcow.conf'
%{ endif ~}
%{ if mailcow_acme_staging ~}
  - echo 'LE_STAGING=y' >> '${mailcow_install_path}/mailcow.conf'
%{ endif ~}
%{ if !(mailcow_acme == "out-of-the-box") ~}
  - lineinfile --regexp 'SKIP_LETS_ENCRYPT=' --line 'SKIP_LETS_ENCRYPT=y' '${mailcow_install_path}/mailcow.conf'
%{ endif ~}
%{ if !mailcow_dovecot_master_auto_generated ~}
  - lineinfile --regexp 'DOVECOT_MASTER_USER=' --line 'DOVECOT_MASTER_USER=${mailcow_dovecot_master_user}' '${mailcow_install_path}/mailcow.conf'
  - lineinfile --regexp 'DOVECOT_MASTER_PASS=' --line 'DOVECOT_MASTER_PASS=${mailcow_dovecot_master_password}' '${mailcow_install_path}/mailcow.conf'
%{ endif ~}