- path: ${configuration_home}/sites-available/${server_fqdn}_http.conf
  content: |
    server {
        server_tokens off;
        listen [::]:80;
        listen      80;
        server_name ${server_name};
        ${nginx_gnu_add_header}

        # Redirect all non-https requests
        rewrite ^ https://$host$request_uri? permanent;
    }
  permissions: 0644
