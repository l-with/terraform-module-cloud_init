- path: ${configuration_home}/sites-available/${server_fqdn}_https.conf
  content: |
    ${https_map}
    server {
      server_tokens off;
      ${gnu_add_header}

${ssl_part}

      server_name ${server_name};

      ${https_conf}

    }
  permissions: 0644
