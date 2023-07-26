# Terraform Modul cloud_init

Terraform module to template cloud-init user data

## Disclaimer

currently only tested with Ubuntu Focal Fossa and Jammy Jellyfish

## Motivation

There is a terraform-provider [cloudinit](https://registry.terraform.io/providers/hashicorp/cloudinit), which can be used to render cloud-init data.

This module is not completely generic like [cloudinit](https://registry.terraform.io/providers/hashicorp/cloudinit). It supports the installation of features.
Some features are simple package installations or downloads of tools.
Other features have more functionality.

For instance 

- [docker_container](#docker_container) can be used to configure services that start docker containers.
- [nginx](#nginx) can be used to configure nginx

If you use [docker_container](#docker_container) then [docker](#docker) is activated automatically.

There are more sophisticated features like `vault_init` in [vault](#vault) that automatically installs 
the needed features for the logic in the `runcmd` section for `vault_init`.

## Technical aspects

The following cloud-init modules are used

- [Package Update Upgrade Install](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#package-update-upgrade-install)
- [Runcmd](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#runcmd)
- [Write Files](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#write-files)

The execution order in cloud-init for these modules is

- init stage
  - write-files
- config stage
  - runcmd 
- final stage
  - package-update-upgrade-install

The consequence for the implementation in this module is that tools that are used for configuration are installed by the runcmd module even if there is a package for the tool. 

## Features

### b2

s. [B2 Command Line Tool](https://github.com/Backblaze/B2_Command_Line_Tool/releases)

For input variables: s. [b2](#input_b2).

### certbot

s. [certbot](https://eff-certbot.readthedocs.io/en/stable/install.html#installation)

For input variables: s. [certbot](#input_certbot).

### comment

add comments to cloud-init user data

This can be used to change cloud-init user-data to trigger rebuild without changing relevant data. 

For input variables: s. [comment](#input_comment).

### croc

s. [croc](https://github.com/schollz/croc#install)

For input variables: s. [croc](#input_croc).

### docker

s. [docker](https://docs.docker.com/engine/install/ubuntu/)

For input variables: s. [docker](#input_docker).

### docker_container

s. [docker](https://docs.docker.com/engine/reference/run/)

For input variables: s. [docker_container](#input_docker_container).

### duplicacy

s. [duplicacy](https://github.com/gilbertchen/duplicacy)

For input variables: s. [duplicacy](#input_duplicacy).

### encrypted packages

For input variables: s. [encrypted_packages](#input_encrypted_packages).

### fail2ban

s. [fail2ban](https://www.fail2ban.org/wiki/index.php/Downloads)

For input variables: s. [fail2ban](#input_fail2ban).

### gettext_base

s. [gettext-base](https://packages.ubuntu.com/search?suite=default&section=all&arch=any&keywords=gettext-base&searchon=names)

For input variables: s. [gettext_base](#input_gettext_base).

### haproxy

s. [haproxy](http://docs.haproxy.org)

For input variables: s. [haproxy](#input_haproxy).

### jq

s. [jq](https://stedolan.github.io/jq/)

For input variables: s. [jq](#input_jq).

### mailcow

s. [mailcow](https://docs.mailcow.email)

For input variables: s. [mailcow](#input_mailcow).

### lineinfile

s. [lineinfile](https://github.com/l-with/lineinfile)

For input variables: s. [lineinfile](#input_lineinfile).

### network

for network configurations

This is executed first in the cloud-init runcmd module.

For input variables: s. [network](#input_network).

### nginx

s. [nginx](https://nginx.org)

For input variables: s. [nginx](#input_nginx).

### package

s. [package](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#package-update-upgrade-install)

For input variables: s. [package](#input_package).

### rke2

s. [rke2](https://docs.rke2.io/install/ha)

Two different cloud-init userdata can be generated
- for the 1st node
- for the other nodes

The certificates for RKE2 are fetched from a package registry 
and decrypted with openssl and thus have to pre pre-built.
The package also has to contain templates for `/etc/rancher/rke2/config.yaml`:

- `/root/config.yaml.node_1st.envtpl` for the first node
- `/root/config.yaml.node_other.envtpl` for the other nodes

The Cloud-init for the 1st node waits for all nodes to become ready
and then puts the created `rke2.yaml` modified 
(substitute 127.0.0.1 with the ipv4-address of the 1st node) into Hashicorp Vault.

The [cert-manager](https://github.com/cert-manager/cert-manager) `cert-manager.crds.yaml` 
is pre-installed as manifest in the 1st node.

For input variables: s. [rke2](#input_rke2).

### runcmd

generic gereration of runcmd scripts

For input variables: s. [runcmd](#input_runcmd).

### s3cmd

s. [S3cmd](https://github.com/s3tools/s3cmd)

For input variables: s. [s3cmd](#input_s3cmd).

### terraform

s. [terraform](https://developer.hashicorp.com/terraform/downloads)

For input variables: s. [terraform](#input_terraform)

### vault

s. [vault](https://developer.hashicorp.com/vault/downloads)

For input variables: s. [vault](#input_vault).

### wait_until

s. [wait_until](https://github.com/l-with/wait-until)

For input variables: s. [wait_until](#wait_until).

### write_file

generic writing of files

For input variables: s. [write_file](#write_file).

## terraform

<!-- BEGIN_TF_DOCS -->
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_external"></a> [external](#requirement\_external) | ~> 2.3.1 |

#### Providers

No providers.

#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_init_part"></a> [cloud\_init\_part](#module\_cloud\_init\_part) | ./modules/cloud_init_part | n/a |
| <a name="module_duplicacy_script"></a> [duplicacy\_script](#module\_duplicacy\_script) | ./modules/duplicacy_script | n/a |
| <a name="module_duplicacy_storage_backend_one_of"></a> [duplicacy\_storage\_backend\_one\_of](#module\_duplicacy\_storage\_backend\_one\_of) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_either_rke2_node_1st_or_rke2_node_other"></a> [either\_rke2\_node\_1st\_or\_rke2\_node\_other](#module\_either\_rke2\_node\_1st\_or\_rke2\_node\_other) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_mailcow_needs_mailcow_hostname"></a> [mailcow\_needs\_mailcow\_hostname](#module\_mailcow\_needs\_mailcow\_hostname) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_not_mailcow_dovecot_master_auto_generated_needs_mailcow_dovecot_master_user_and_mailcow_dovecot_master_password"></a> [not\_mailcow\_dovecot\_master\_auto\_generated\_needs\_mailcow\_dovecot\_master\_user\_and\_mailcow\_dovecot\_master\_password](#module\_not\_mailcow\_dovecot\_master\_auto\_generated\_needs\_mailcow\_dovecot\_master\_user\_and\_mailcow\_dovecot\_master\_password) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_1st_needs_rke2_node_1st_rke2_role_id"></a> [rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_role\_id](#module\_rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_role\_id) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_1st_needs_rke2_node_1st_rke2_secret_id"></a> [rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_secret\_id](#module\_rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_secret\_id) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_1st_needs_vault_addr"></a> [rke2\_node\_1st\_needs\_vault\_addr](#module\_rke2\_node\_1st\_needs\_vault\_addr) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_encrypted_package_api_header"></a> [rke2\_node\_needs\_encrypted\_package\_api\_header](#module\_rke2\_node\_needs\_encrypted\_package\_api\_header) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_cert_package_url"></a> [rke2\_node\_needs\_rke2\_node\_cert\_package\_url](#module\_rke2\_node\_needs\_rke2\_node\_cert\_package\_url) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_pre_shared_secret"></a> [rke2\_node\_needs\_rke2\_node\_pre\_shared\_secret](#module\_rke2\_node\_needs\_rke2\_node\_pre\_shared\_secret) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_rke2_node_cert_package_secret"></a> [rke2\_node\_needs\_rke2\_node\_rke2\_node\_cert\_package\_secret](#module\_rke2\_node\_needs\_rke2\_node\_rke2\_node\_cert\_package\_secret) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_other_needs_rke2_node_other_node_1st_ip"></a> [rke2\_node\_other\_needs\_rke2\_node\_other\_node\_1st\_ip](#module\_rke2\_node\_other\_needs\_rke2\_node\_other\_node\_1st\_ip) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_vault_init_needs_jq_install_method_binary"></a> [vault\_init\_needs\_jq\_install\_method\_binary](#module\_vault\_init\_needs\_jq\_install\_method\_binary) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_vault_init_needs_vault_init_addr"></a> [vault\_init\_needs\_vault\_init\_addr](#module\_vault\_init\_needs\_vault\_init\_addr) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_vault_init_needs_vault_init_public_key"></a> [vault\_init\_needs\_vault\_init\_public\_key](#module\_vault\_init\_needs\_vault\_init\_public\_key) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_vault_init_vault_key_threshold_less_than_or_equal_vault_key_shares"></a> [vault\_init\_vault\_key\_threshold\_less\_than\_or\_equal\_vault\_key\_shares](#module\_vault\_init\_vault\_key\_threshold\_less\_than\_or\_equal\_vault\_key\_shares) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_vault_install_method_binary_needs_vault_version"></a> [vault\_install\_method\_binary\_needs\_vault\_version](#module\_vault\_install\_method\_binary\_needs\_vault\_version) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_vault_tls_file_encoding_either_text_plain_or_base64"></a> [vault\_tls\_file\_encoding\_either\_text\_plain\_or\_base64](#module\_vault\_tls\_file\_encoding\_either\_text\_plain\_or\_base64) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_write_files_encoding_either_text_plain_or_base64"></a> [write\_files\_encoding\_either\_text\_plain\_or\_base64](#module\_write\_files\_encoding\_either\_text\_plain\_or\_base64) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |

#### Resources

No resources.

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_b2"></a> [b2](#input\_b2) | if cloud-init user data for installing the [BlackBlaze CLI](https://www.backblaze.com/b2/docs/quick_command_line.html) should be generated | `bool` | `false` | no |
| <a name="input_certbot"></a> [certbot](#input\_certbot) | if cloud-init user data for installing certbot should be generated | `bool` | `false` | no |
| <a name="input_certbot_automatic_renewal_cron"></a> [certbot\_automatic\_renewal\_cron](#input\_certbot\_automatic\_renewal\_cron) | the cron schedule expression for certbot renewal | `string` | `"0 */12 * * *"` | no |
| <a name="input_certbot_automatic_renewal_cronjob"></a> [certbot\_automatic\_renewal\_cronjob](#input\_certbot\_automatic\_renewal\_cronjob) | the cron job for certbot renewal | `string` | `"test -x /usr/bin/certbot -a \\! -d /run/systemd/system && perl -e 'sleep int(rand(43200))' && certbot -q renew"` | no |
| <a name="input_certbot_automatic_renewal_post_hooks"></a> [certbot\_automatic\_renewal\_post\_hooks](#input\_certbot\_automatic\_renewal\_post\_hooks) | the certbot automatic renewal post hook scripts | <pre>list(object({<br>    file_name = string<br>    content   = string<br>  }))</pre> | `[]` | no |
| <a name="input_certbot_dns_plugins"></a> [certbot\_dns\_plugins](#input\_certbot\_dns\_plugins) | the list of certbot plugins to be installed | `list(string)` | `[]` | no |
| <a name="input_comment"></a> [comment](#input\_comment) | if cloud-init user data with comments should be generated | `bool` | `false` | no |
| <a name="input_comments"></a> [comments](#input\_comments) | the comments to be added to cloud-init user data<br>    this can be used to change cloud-init user-data to trigger rebuild without changing relevant data | `list(string)` | `[]` | no |
| <a name="input_croc"></a> [croc](#input\_croc) | if cloud-init user data for installing croc should be generated | `bool` | `false` | no |
| <a name="input_docker"></a> [docker](#input\_docker) | if cloud-init user data for installing docker should be generated | `bool` | `false` | no |
| <a name="input_docker_container"></a> [docker\_container](#input\_docker\_container) | if cloud-init user data for installing docker containers should be generated | `bool` | `false` | no |
| <a name="input_docker_container_list"></a> [docker\_container\_list](#input\_docker\_container\_list) | the docker containers the cloud-init user data should be generated for | <pre>list(object({<br>    name    = string, // --name<br>    image   = string,<br>    ports   = optional(string, null), // --publish<br>    command = string,<br>  }))</pre> | `[]` | no |
| <a name="input_docker_manipulate_iptables"></a> [docker\_manipulate\_iptables](#input\_docker\_manipulate\_iptables) | if docker manipulate ip-tables should _not_ be generated for cloud-init user data for docker | `bool` | `true` | no |
| <a name="input_duplicacy"></a> [duplicacy](#input\_duplicacy) | if cloud-init user data for installing duplicacy should be generated | `bool` | `false` | no |
| <a name="input_duplicacy_configurations"></a> [duplicacy\_configurations](#input\_duplicacy\_configurations) | the duplicacy configurations | <pre>list(object({<br>    working_directory     = string, // the working directory for duplicacy which is the default path for the repository to backup<br>    password              = string, // the value for `DUPLICACY_PASSWORD`, e.g. the passphrase to encrypt the backups with before they are stored remotely<br>    script_file_directory = string, // the path where the scripts for `duplicacy init`, `duplicacy backup`, `duplicacy restore` and `duplicacy prune` are created<br><br>    storage_backend                  = string,                                                                  // the storage backend, possible values are `Local disk`, `Backblaze B2`, `SSH/SFTP Password`, `SSH/SFTP Keyfile`, `Onedrive`<br>    b2_id                            = optional(string),                                                        // the value for `DUPLICACY_B2_ID`<br>    b2_key                           = optional(string),                                                        // the value for `DUPLICACY_B2_KEY`<br>    ssh_password                     = optional(string),                                                        // the value for `DUPLICACY_SSH_PASSWORD`<br>    ssh_passphrase                   = optional(string),                                                        // the value for `DUPLICACY_SSH_PASSPHRASE`<br>    secret_file_directory            = optional(string, "/opt/duplicacy/secret"),                               // the path where the token and the ssh-key files are created<br>    onedrive_token_file_name         = optional(string, "one-token.json"),                                      // the filename for `DUPLICACY_ONE_TOKEN`<br>    ssh_key_file_name                = optional(string, "id"),                                                  // the filename for `DUPLICACY_SSH_KEY_FILE`<br>    secret_file_content              = optional(string),                                                        // the content for onedrive_token_file_name or ssh_key_file_name<br>    snapshot_id                      = string,                                                                  // the `<snapshot id>` for `duplicacy init`<br>    storage_url                      = string,                                                                  // the `<storage url>` for ´duplicacy init`, e.g. the [Duplicacy URI](https://github.com/gilbertchen/duplicacy/wiki/Storage-Backends) of where to store the backups<br>    init_script_file_name            = optional(string, "init"),                                                // the duplicacy init script file name<br>    backup_script_file_name          = optional(string, "backup"),                                              // the duplicacy backup script file name<br>    prune_script_file_name           = optional(string, "prune"),                                               // the duplicacy prune script file name<br>    restore_script_file_name         = optional(string, "restore"),                                             // the duplicacy restore script file name<br>    init_options                     = optional(string, "-encrypt"),                                            // the options for `duplicacy init`<br>    backup_options                   = optional(string, ""),                                                    // the options for `duplicacy backup`<br>    prune_options                    = optional(string, "-keep 365:3650 -keep 30:365 -keep 7:30 -keep 1:7 -a"), // the options for `duplicacy prune`<br>    restore_options                  = optional(string, "-overwrite"),                                          // the options for `duplicacy restore`<br>    log_file_directory               = optional(string, "/opt/mailcow/duplicacy/log"),                          // the directory for the script log files<br>    backup_log_file_name             = optional(string, "backup.log"),                                          // the file name of the backup log file<br>    prune_log_file_name              = optional(string, "prune.log"),                                           // the file name of the prune log file<br>    restore_log_file_name            = optional(string, "restore.log"),                                         // the file name of the restore log file<br>    pre_backup_script_file_name      = optional(string, "pre-backup"),                                          // the file name of the pre backup script<br>    post_backup_script_file_name     = optional(string, "post-backup"),                                         // the file name of the post backup script<br>    pre_prune_script_file_name       = optional(string, "pre-prune"),                                           // the file name of the pre prune script<br>    post_prune_script_file_name      = optional(string, "post-prune"),                                          // the file name of the post prune script<br>    pre_restore_script_file_name     = optional(string, "pre-restore"),                                         // the file name of the pre restore script<br>    post_restore_script_file_name    = optional(string, "post-restore"),                                        // the file name of the post restore script<br>    pre_backup_script_file_content   = optional(string, null),                                                  // the content for the pre backup script<br>    post_backup_script_file_content  = optional(string, null),                                                  // the content for the pre backup script<br>    pre_prune_script_file_content    = optional(string, null),                                                  // the content for the pre prune script<br>    post_prune_script_file_content   = optional(string, null),                                                  // the content for the pre prune script<br>    pre_restore_script_file_content  = optional(string, null),                                                  // the content for the pre restore script<br>    post_restore_script_file_content = optional(string, null),                                                  // the content for the pre restore script<br>  }))</pre> | `[]` | no |
| <a name="input_duplicacy_path"></a> [duplicacy\_path](#input\_duplicacy\_path) | the path to install duplicacy | `string` | `"/opt/duplicacy"` | no |
| <a name="input_duplicacy_version"></a> [duplicacy\_version](#input\_duplicacy\_version) | the duplicacy version to install | `string` | `"3.1.0"` | no |
| <a name="input_encrypted_packages"></a> [encrypted\_packages](#input\_encrypted\_packages) | if cloud-init user data for the encrypted packages should be generated | `bool` | `false` | no |
| <a name="input_encrypted_packages_list"></a> [encrypted\_packages\_list](#input\_encrypted\_packages\_list) | the encrypted packages the cloud-init user data should be generated for | <pre>list(object({<br>    url        = string                 // the url to get the package from<br>    api_header = string                 // the header to authorize getting the package<br>    secret     = string                 // the secret to decrypt the package (`openssl enc -aes-256-cbc -pbkdf2`)"<br>    post_cmd   = optional(string, null) // the command to be executed after the installing the package<br>  }))</pre> | `[]` | no |
| <a name="input_fail2ban"></a> [fail2ban](#input\_fail2ban) | if cloud-init user data for installing fail2ban should be generated | `bool` | `false` | no |
| <a name="input_fail2ban_recidive"></a> [fail2ban\_recidive](#input\_fail2ban\_recidive) | if recidive jail install should be generated | `bool` | `true` | no |
| <a name="input_fail2ban_sshd"></a> [fail2ban\_sshd](#input\_fail2ban\_sshd) | if sshd jail install should be generated | `bool` | `true` | no |
| <a name="input_gettext_base"></a> [gettext\_base](#input\_gettext\_base) | if cloud-init user data for installing gettext-base should be generated | `bool` | `false` | no |
| <a name="input_haproxy"></a> [haproxy](#input\_haproxy) | if cloud-init user data for installing haproxy should be generated | `bool` | `false` | no |
| <a name="input_haproxy_configuration"></a> [haproxy\_configuration](#input\_haproxy\_configuration) | the configuration for [haproxy](https://www.haproxy.com/documentation/hapee/latest/configuration/config-sections/overview/#haproxy-enterprise-configuration-sections)<br>    the string '$ipv4\_public\_address' can be used as placeholder for the public ipv4-address of the server<br>    (ip route get 8.8.8.8 \| grep 8.8.8.8 \| cut -d ' ' -f 7) | <pre>object({<br>    global = optional(<br>      object({<br>        configuration = string,<br>      }),<br>      {<br>        configuration = <<EOT<br>  log /dev/log local0<br>  log /dev/log local1 notice<br>  chroot /var/lib/haproxy<br>  stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners<br>  stats timeout 30s<br>  user haproxy<br>  group haproxy<br>  daemon<br><br>  # Default SSL material locations<br>  ca-base /etc/ssl/certs<br>  crt-base /etc/ssl/private<br><br>  # See: https://ssl-config.mozilla.org/#server=haproxy&server-version=2.0.3&config=intermediate<br>  ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384<br>  ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256<br>  ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets<br>EOT<br>      }<br>    ),<br>    global_additional = optional(<br>      object({<br>        configuration = optional(string)<br>      }),<br>      {}<br>    )<br>    frontend = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    backend = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    defaults = optional(<br>      list(object({<br>        configuration = string,<br>        })<br>      ),<br>      [<br>        {<br>          configuration = <<EOT<br>  log global<br>  mode http<br>  option httplog<br>  option dontlognull<br>  timeout connect 5000<br>  timeout client 50000<br>  timeout server 50000<br>  errorfile 400 /etc/haproxy/errors/400.http<br>  errorfile 403 /etc/haproxy/errors/403.http<br>  errorfile 408 /etc/haproxy/errors/408.http<br>  errorfile 500 /etc/haproxy/errors/500.http<br>  errorfile 502 /etc/haproxy/errors/502.http<br>  errorfile 503 /etc/haproxy/errors/503.http<br>  errorfile 504 /etc/haproxy/errors/504.http<br>EOT<br>      }]<br>    ),<br>    listen = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    aggregations = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    cache = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    dynamic-update = optional(list(string), []),<br>    fcgi-app = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    http-errors = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    mailers = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    peers = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    program = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    resolvers = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    ring = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>    userlist = optional(<br>      list(object({<br>        label         = string,<br>        configuration = string,<br>      })),<br>      []<br>    ),<br>  })</pre> | `null` | no |
| <a name="input_jq"></a> [jq](#input\_jq) | if cloud-init user data for installing jq should be generated | `bool` | `false` | no |
| <a name="input_jq_install_method"></a> [jq\_install\_method](#input\_jq\_install\_method) | the install method, supported methods are 'binary', 'packages'<br>  - 'binary' uses jq\_version<br>  - 'packages' implies that jq can not be used for configuring inside cloud-init | `string` | `"binary"` | no |
| <a name="input_jq_version"></a> [jq\_version](#input\_jq\_version) | the jq version to be installed | `string` | `"1.6"` | no |
| <a name="input_lineinfile"></a> [lineinfile](#input\_lineinfile) | if cloud-init user data for installing [lineinfile](https://github.com/l-with/lineinfile) should be generated | `bool` | `false` | no |
| <a name="input_lnxrouter"></a> [lnxrouter](#input\_lnxrouter) | if cloud-init user data for installing lnxrouter should be generated | `bool` | `false` | no |
| <a name="input_lnxrouter_arguments"></a> [lnxrouter\_arguments](#input\_lnxrouter\_arguments) | - ip\_address: specifies the interface ($interface in arguments)<br>    - arguments: specifies the command line arguments to start lnxrouter with, $interface will be substituted by the name of the interface bound to the ip\_address (`ifconfig | grep --before-context=1 10.0.0.20 | grep --only-matching "^\w*"`) | <pre>object({<br>    ip_address = optional(string, null)<br>    arguments  = string<br>  })</pre> | `null` | no |
| <a name="input_lnxrouter_start"></a> [lnxrouter\_start](#input\_lnxrouter\_start) | if lnxrouter should be started | `bool` | `false` | no |
| <a name="input_mailcow"></a> [mailcow](#input\_mailcow) | if cloud-init user data for installing mailcow should be generated | `bool` | `false` | no |
| <a name="input_mailcow_acme"></a> [mailcow\_acme](#input\_mailcow\_acme) | the way the Let's Encrypt certificate ist obtained:<br>    `out-the-box`:  The "acme-mailcow" container will try to obtain a LE certificate.<br>    `certbot`: The certbot cronjob will manage Let's Encrypt certificates<br>    if the Let's Encrypt certificate is obtained out-of-the-box | `string` | `"out-of-the-box"` | no |
| <a name="input_mailcow_acme_staging"></a> [mailcow\_acme\_staging](#input\_mailcow\_acme\_staging) | if ACME staging should be used (s. https://mailcow.github.io/mailcow-dockerized-docs/firststeps-ssl/#test-against-staging-acme-directory) | `bool` | `false` | no |
| <a name="input_mailcow_additional_san"></a> [mailcow\_additional\_san](#input\_mailcow\_additional\_san) | the additional domains (SSL Certificate Subject Alternative Names), for instance autodiscover.*,autoconfig.* | `string` | `null` | no |
| <a name="input_mailcow_admin_password"></a> [mailcow\_admin\_password](#input\_mailcow\_admin\_password) | the password for the mailcow administrator | `string` | `null` | no |
| <a name="input_mailcow_admin_user"></a> [mailcow\_admin\_user](#input\_mailcow\_admin\_user) | the username of the mailcow administrator | `string` | `null` | no |
| <a name="input_mailcow_api_allow_from"></a> [mailcow\_api\_allow\_from](#input\_mailcow\_api\_allow\_from) | list of IPs to allow API access from | `list(string)` | `[]` | no |
| <a name="input_mailcow_api_key"></a> [mailcow\_api\_key](#input\_mailcow\_api\_key) | the API key for mailcow read-write access (allowed characters: a-z, A-Z, 0-9, -) | `string` | `null` | no |
| <a name="input_mailcow_api_key_read_only"></a> [mailcow\_api\_key\_read\_only](#input\_mailcow\_api\_key\_read\_only) | the API key for mailcow read-only access (allowed characters: a-z, A-Z, 0-9, -) | `string` | `null` | no |
| <a name="input_mailcow_backup_path"></a> [mailcow\_backup\_path](#input\_mailcow\_backup\_path) | the path for the mailcow backup | `string` | `"/var/backups/mailcow"` | no |
| <a name="input_mailcow_backup_script"></a> [mailcow\_backup\_script](#input\_mailcow\_backup\_script) | the full path for the mailcow backup script | `string` | `"/opt/mailcow/scripts/mailcow-backup.sh"` | no |
| <a name="input_mailcow_branch"></a> [mailcow\_branch](#input\_mailcow\_branch) | the branch value for mailcow (`MAILCOW_BRANCH`) | `string` | `"master"` | no |
| <a name="input_mailcow_certbot_post_hook_script"></a> [mailcow\_certbot\_post\_hook\_script](#input\_mailcow\_certbot\_post\_hook\_script) | the full path for the mailcow certbot post-hook script | `string` | `"/etc/letsencrypt/renewal-hooks/post/mailcow_certbot_post_hook.sh"` | no |
| <a name="input_mailcow_configure_backup"></a> [mailcow\_configure\_backup](#input\_mailcow\_configure\_backup) | if backup for mailcow should be configured for unattended backup | `bool` | `false` | no |
| <a name="input_mailcow_delete_default_admin_script"></a> [mailcow\_delete\_default\_admin\_script](#input\_mailcow\_delete\_default\_admin\_script) | the full path for the mailcow delete admin script | `string` | `"/root/mailcow_delete_default_admin.sh"` | no |
| <a name="input_mailcow_docker_compose_project_name"></a> [mailcow\_docker\_compose\_project\_name](#input\_mailcow\_docker\_compose\_project\_name) | the name for the mailcow docker compose project | `string` | `null` | no |
| <a name="input_mailcow_dovecot_master_auto_generated"></a> [mailcow\_dovecot\_master\_auto\_generated](#input\_mailcow\_dovecot\_master\_auto\_generated) | if the dovecot master user and password should be auto-generated | `bool` | `true` | no |
| <a name="input_mailcow_dovecot_master_password"></a> [mailcow\_dovecot\_master\_password](#input\_mailcow\_dovecot\_master\_password) | the password for the dovecot master user (DOVECOT\_MASTER\_PASS) if not auto-generated | `string` | `null` | no |
| <a name="input_mailcow_dovecot_master_user"></a> [mailcow\_dovecot\_master\_user](#input\_mailcow\_dovecot\_master\_user) | the username of the dovecot master user (DOVECOT\_MASTER\_USER) if not auto-generated | `string` | `null` | no |
| <a name="input_mailcow_greylisting"></a> [mailcow\_greylisting](#input\_mailcow\_greylisting) | if greylisting should be active | `bool` | `true` | no |
| <a name="input_mailcow_hostname"></a> [mailcow\_hostname](#input\_mailcow\_hostname) | the host name for mailcow | `string` | `null` | no |
| <a name="input_mailcow_install_path"></a> [mailcow\_install\_path](#input\_mailcow\_install\_path) | the install path for mailcow | `string` | `"/opt/mailcow-dockerized"` | no |
| <a name="input_mailcow_mynetworks"></a> [mailcow\_mynetworks](#input\_mailcow\_mynetworks) | the list of subnetwork masks to add to `mynetworks` in postfix<br>    if subnetwork masks are provided at the beginning `127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 [fe80::]/10` is added (local) | `list(string)` | `[]` | no |
| <a name="input_mailcow_restore_script"></a> [mailcow\_restore\_script](#input\_mailcow\_restore\_script) | the full path for the mailcow restore script | `string` | `"/opt/mailcow/scripts/mailcow-restore.sh"` | no |
| <a name="input_mailcow_rspamd_ui_password"></a> [mailcow\_rspamd\_ui\_password](#input\_mailcow\_rspamd\_ui\_password) | the password for the mailcow Rspamd UI | `string` | `null` | no |
| <a name="input_mailcow_set_admin_script"></a> [mailcow\_set\_admin\_script](#input\_mailcow\_set\_admin\_script) | the full path for the mailcow set admin script | `string` | `"/root/mailcow_set_admin.sh"` | no |
| <a name="input_mailcow_set_rspamd_ui_password_script"></a> [mailcow\_set\_rspamd\_ui\_password\_script](#input\_mailcow\_set\_rspamd\_ui\_password\_script) | the full path for the mailcow set Rspamd UI password script | `string` | `"/root/mailcow_set_rspamd_ui_password.sh"` | no |
| <a name="input_mailcow_submission_port"></a> [mailcow\_submission\_port](#input\_mailcow\_submission\_port) | the [postfix submission](https://docs.mailcow.email/prerequisite/prerequisite-system/?h=submission#default-ports) port (SUBMISSION\_PORT in mailcow.conf) | `number` | `null` | no |
| <a name="input_mailcow_timezone"></a> [mailcow\_timezone](#input\_mailcow\_timezone) | the time zone value for mailcow (`MAILCOW_TZ`) | `string` | `"Europe/Berlin"` | no |
| <a name="input_mailcow_version"></a> [mailcow\_version](#input\_mailcow\_version) | the [version](https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefpathspecapathspec) to checkout<br>    default is [mailcow\_branch](#input\_mailcow\_branch) (coded in terraform) | `string` | `null` | no |
| <a name="input_network"></a> [network](#input\_network) | if the network should be configured | `bool` | `false` | no |
| <a name="input_network_dispatcher_script_path"></a> [network\_dispatcher\_script\_path](#input\_network\_dispatcher\_script\_path) | the path where network dispatcher scripts should placed | `string` | `"/etc/network-dispatcher"` | no |
| <a name="input_network_dispatcher_scripts"></a> [network\_dispatcher\_scripts](#input\_network\_dispatcher\_scripts) | the network dispatcher scripts to be placed at network\_dispatcher\_script\_path and executed<br>    the string '$public\_interface' can be used as placeholder for the device for internet access<br>    (ip route get 8.8.8.8 \| grep 8.8.8.8 \| cut -d ' ' -f 5) | <pre>list(object({<br>    script_file_name    = string,<br>    script_file_content = string,<br>  }))</pre> | `[]` | no |
| <a name="input_network_resolved_conf_path"></a> [network\_resolved\_conf\_path](#input\_network\_resolved\_conf\_path) | the path where network resolved configurations should placed | `string` | `"/etc/systemd/resolved.conf.d/"` | no |
| <a name="input_network_resolved_confs"></a> [network\_resolved\_confs](#input\_network\_resolved\_confs) | the resolved configuration files to be placed at network\_resolved\_conf\_path<br>  the service systemd-resolved is restarted | <pre>list(object({<br>    conf_file_name    = string,<br>    conf_file_content = string<br>  }))</pre> | `[]` | no |
| <a name="input_nginx"></a> [nginx](#input\_nginx) | if cloud-init user data for installing nginx should be generated | `bool` | `false` | no |
| <a name="input_nginx_configuration_home"></a> [nginx\_configuration\_home](#input\_nginx\_configuration\_home) | the nginx configuration home | `string` | `"/etc/nginx"` | no |
| <a name="input_nginx_confs"></a> [nginx\_confs](#input\_nginx\_confs) | the extra configurations for nginx | <pre>list(object({<br>    port        = number // the port for `listen`<br>    server_name = string // the server_name for `server_name`<br>    fqdn        = string // the FQDN used for include Let's Encrypt certificates: `/etc/letsencrypt/live/{{ nginx_conf.FQDN }}/...`<br>    conf        = string // the configuration to be included in the `sever` stanza<br>  }))</pre> | `[]` | no |
| <a name="input_nginx_gnu"></a> [nginx\_gnu](#input\_nginx\_gnu) | if the [GNU Terry Pratchett](http://www.gnuterrypratchett.com) header should be inserted | `bool` | `true` | no |
| <a name="input_nginx_https_conf"></a> [nginx\_https\_conf](#input\_nginx\_https\_conf) | the nginx https configuration after `server_name` | `string` | `null` | no |
| <a name="input_nginx_https_map"></a> [nginx\_https\_map](#input\_nginx\_https\_map) | the map stanza configuration for nginx https configuration | `string` | `null` | no |
| <a name="input_nginx_server_fqdn"></a> [nginx\_server\_fqdn](#input\_nginx\_server\_fqdn) | the FQDN of the server for nginx server\_name and Let's Encrypt certificates | `string` | `null` | no |
| <a name="input_package"></a> [package](#input\_package) | if cloud-init user data for package should be generated | `bool` | `true` | no |
| <a name="input_package_reboot_if_required"></a> [package\_reboot\_if\_required](#input\_package\_reboot\_if\_required) | if cloud-init user data for package\_reboot\_if\_required should be generated | `bool` | `false` | no |
| <a name="input_package_update"></a> [package\_update](#input\_package\_update) | if cloud-init user data for package\_update should be generated | `bool` | `true` | no |
| <a name="input_package_upgrade"></a> [package\_upgrade](#input\_package\_upgrade) | if cloud-init user data for package\_upgrade should be generated | `bool` | `true` | no |
| <a name="input_packages"></a> [packages](#input\_packages) | the list of packages to be installed | `list(string)` | `[]` | no |
| <a name="input_python3_pip"></a> [python3\_pip](#input\_python3\_pip) | if cloud-init user data for installing python3-pip should be generated | `bool` | `false` | no |
| <a name="input_rke2"></a> [rke2](#input\_rke2) | if cloud-init user data for the rke2 should be generated | `bool` | `false` | no |
| <a name="input_rke2_node_1st"></a> [rke2\_node\_1st](#input\_rke2\_node\_1st) | if cloud-init user data for the rke2 1st node should be generated | `bool` | `false` | no |
| <a name="input_rke2_node_1st_cert_manager_crd_version"></a> [rke2\_node\_1st\_cert\_manager\_crd\_version](#input\_rke2\_node\_1st\_cert\_manager\_crd\_version) | the version of cert-manager CRDs to be installed | `string` | `"1.11.0"` | no |
| <a name="input_rke2_node_1st_rke2_role_id"></a> [rke2\_node\_1st\_rke2\_role\_id](#input\_rke2\_node\_1st\_rke2\_role\_id) | the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault | `string` | `null` | no |
| <a name="input_rke2_node_1st_rke2_secret_id"></a> [rke2\_node\_1st\_rke2\_secret\_id](#input\_rke2\_node\_1st\_rke2\_secret\_id) | the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault | `string` | `null` | no |
| <a name="input_rke2_node_1st_vault_addr"></a> [rke2\_node\_1st\_vault\_addr](#input\_rke2\_node\_1st\_vault\_addr) | the vault address to put the `rke2.yml` as kv into | `string` | `null` | no |
| <a name="input_rke2_node_1st_vault_field"></a> [rke2\_node\_1st\_vault\_field](#input\_rke2\_node\_1st\_vault\_field) | the vault field used to put the `rke2.yaml` as kv into vault | `string` | `"rke2_yaml"` | no |
| <a name="input_rke2_node_1st_vault_mount"></a> [rke2\_node\_1st\_vault\_mount](#input\_rke2\_node\_1st\_vault\_mount) | the vault mount used to put the `rke2.yaml` as kv into vault | `string` | `"gitlab"` | no |
| <a name="input_rke2_node_1st_vault_path"></a> [rke2\_node\_1st\_vault\_path](#input\_rke2\_node\_1st\_vault\_path) | the vault path used to put the `rke2.yaml` as kv into vault | `string` | `"rancher/kubeconfig"` | no |
| <a name="input_rke2_node_cert_package_api_header"></a> [rke2\_node\_cert\_package\_api\_header](#input\_rke2\_node\_cert\_package\_api\_header) | the header to authorize getting the cert-package | `string` | `null` | no |
| <a name="input_rke2_node_cert_package_secret"></a> [rke2\_node\_cert\_package\_secret](#input\_rke2\_node\_cert\_package\_secret) | the secret to decrypt the cert package (`openssl enc -aes-256-cbc -pbkdf2`) | `string` | `null` | no |
| <a name="input_rke2_node_cert_package_url"></a> [rke2\_node\_cert\_package\_url](#input\_rke2\_node\_cert\_package\_url) | the url to get the cert-package from | `string` | `null` | no |
| <a name="input_rke2_node_config_addendum"></a> [rke2\_node\_config\_addendum](#input\_rke2\_node\_config\_addendum) | the addendum to the rke2 config after the lines 'token: ...' and optional 'server: ...' | `string` | `"cni: cilium"` | no |
| <a name="input_rke2_node_other"></a> [rke2\_node\_other](#input\_rke2\_node\_other) | if cloud-init user data for the rke2 other nodes should be generated | `bool` | `false` | no |
| <a name="input_rke2_node_other_node_1st_ip"></a> [rke2\_node\_other\_node\_1st\_ip](#input\_rke2\_node\_other\_node\_1st\_ip) | the ip of the 1st node for cloud-init user data for rke2 other nodes | `string` | `null` | no |
| <a name="input_rke2_node_pre_shared_secret"></a> [rke2\_node\_pre\_shared\_secret](#input\_rke2\_node\_pre\_shared\_secret) | the pre shared secret for `/etc/rancher/rke2/config.yaml` | `string` | `null` | no |
| <a name="input_runcmd"></a> [runcmd](#input\_runcmd) | if runcmd scripts should be configured | `bool` | `false` | no |
| <a name="input_runcmd_scripts"></a> [runcmd\_scripts](#input\_runcmd\_scripts) | the runcmd scripts to be executed | `list(string)` | `[]` | no |
| <a name="input_s3cmd"></a> [s3cmd](#input\_s3cmd) | if cloud-init user data for installing the [S3cmd](https://github.com/s3tools/s3cmd) should be generated | `bool` | `false` | no |
| <a name="input_terraform"></a> [terraform](#input\_terraform) | if cloud-init user data for installing terraform should be generated | `bool` | `false` | no |
| <a name="input_terraform_install_method"></a> [terraform\_install\_method](#input\_terraform\_install\_method) | the install method, supported methods are 'apt' | `string` | `"apt"` | no |
| <a name="input_vault"></a> [vault](#input\_vault) | if cloud-init user data for installing vault should be generated | `bool` | `false` | no |
| <a name="input_vault_addr"></a> [vault\_addr](#input\_vault\_addr) | the vault address (can be used as default for other features) | `string` | `null` | no |
| <a name="input_vault_api_addr"></a> [vault\_api\_addr](#input\_vault\_api\_addr) | the [api\_addr](https://www.vaultproject.io/docs/configuration#api_addr)<br>    the string '$ipv4\_address' can be used as placeholder for the server ipv4-address | `string` | `"http://$ipv4_address:8200"` | no |
| <a name="input_vault_api_port"></a> [vault\_api\_port](#input\_vault\_api\_port) | the vault api port (for [api\_addr](https://www.vaultproject.io/docs/configuration#api_addr) and [address](https://www.vaultproject.io/docs/configuration/listener/tcp#address)) | `number` | `8200` | no |
| <a name="input_vault_bootstrap_files_path"></a> [vault\_bootstrap\_files\_path](#input\_vault\_bootstrap\_files\_path) | the path where the files needed for bootstrapping are saved | `string` | `"/root"` | no |
| <a name="input_vault_cluster_addr"></a> [vault\_cluster\_addr](#input\_vault\_cluster\_addr) | the [cluster\_addr](https://www.vaultproject.io/docs/configuration#cluster_addr)<br>    the string '$ipv4\_address' can be used as placeholder for the server ipv4-address<br>    (ip addr show \| grep 'inet ' \| grep 'scope global' \| cut -d ' ' -f6 \| cut -d '/' -f 1) | `string` | `"http://$ipv4_address:8201"` | no |
| <a name="input_vault_cluster_port"></a> [vault\_cluster\_port](#input\_vault\_cluster\_port) | the vault cluster port (for [cluster\_addr](https://www.vaultproject.io/docs/configuration#cluster_addr) and [cluster\_address](https://www.vaultproject.io/docs/configuration/listener/tcp#cluster_address)) | `number` | `8201` | no |
| <a name="input_vault_config_path"></a> [vault\_config\_path](#input\_vault\_config\_path) | the path for the vault configuration files | `string` | `"/etc/vault.d"` | no |
| <a name="input_vault_disable_mlock"></a> [vault\_disable\_mlock](#input\_vault\_disable\_mlock) | the value for [disable\_mlock](https://www.vaultproject.io/docs/configuration#disable_mlock) | `bool` | `true` | no |
| <a name="input_vault_home_path"></a> [vault\_home\_path](#input\_vault\_home\_path) | the home of the vault specific files and folders | `string` | `"/srv/vault"` | no |
| <a name="input_vault_init"></a> [vault\_init](#input\_vault\_init) | if vault should be initialized | `bool` | `true` | no |
| <a name="input_vault_init_addr"></a> [vault\_init\_addr](#input\_vault\_init\_addr) | the vault address used for `vault init` during cloud init | `string` | `null` | no |
| <a name="input_vault_init_public_key"></a> [vault\_init\_public\_key](#input\_vault\_init\_public\_key) | the public RSA key the output of the vault initialization is encoded with (to be decryptable by the corresponding private key with [rsadecrypt](https://developer.hashicorp.com/terraform/language/functions/rsadecrypt) | `string` | `null` | no |
| <a name="input_vault_install_method"></a> [vault\_install\_method](#input\_vault\_install\_method) | the install method, supported methods are 'apt', 'binary'<br>  - 'binary' uses vault\_version | `string` | `"apt"` | no |
| <a name="input_vault_key_shares"></a> [vault\_key\_shares](#input\_vault\_key\_shares) | the number of [key shares](https://developer.hashicorp.com/vault/docs/commands/operator/init#key-shares) | `number` | `1` | no |
| <a name="input_vault_key_threshold"></a> [vault\_key\_threshold](#input\_vault\_key\_threshold) | the number of key shares required to reconstruct the root key (s. https://developer.hashicorp.com/vault/docs/commands/operator/init#key-threshold) | `number` | `1` | no |
| <a name="input_vault_listeners"></a> [vault\_listeners](#input\_vault\_listeners) | the list of [listener](https://www.vaultproject.io/docs/configuration/listener/tcp)s<br>    the default for each (coded in terraform)<br>      - tls\_cert\_file is [vault\_tls\_cert\_file](#input\_vault\_tls\_cert\_file)<br>      - tls\_key\_file is [vault\_tls\_key\_file](#input\_vault\_tls\_key\_file)<br>      - tls\_client\_ca\_file [vault\_tls\_client\_ca\_file](#input\_vault\_tls\_client\_ca\_file) | <pre>list(object({<br>    address            = string,<br>    cluster_address    = optional(string, null),<br>    tls_disable        = optional(bool, true),<br>    tls_cert_file      = optional(string, null),<br>    tls_key_file       = optional(string, null),<br>    tls_client_ca_file = optional(string, null),<br>  }))</pre> | `[]` | no |
| <a name="input_vault_log_level"></a> [vault\_log\_level](#input\_vault\_log\_level) | the [vault log level](https://www.vaultproject.io/docs/configuration#log_level) | `string` | `"info"` | no |
| <a name="input_vault_raft_leader_tls_servername"></a> [vault\_raft\_leader\_tls\_servername](#input\_vault\_raft\_leader\_tls\_servername) | the [leader\_tls\_servername](https://www.vaultproject.io/docs/configuration/storage/raft#leader_tls_servername) | `string` | `null` | no |
| <a name="input_vault_remove_vault_init_json"></a> [vault\_remove\_vault\_init\_json](#input\_vault\_remove\_vault\_init\_json) | if the output of the vault initialization should removed<br>    <span style=\"color:red\">ATTENTION: The output of the vault initialization is highly confidential! It is the root of the secret management in vault!</span>" | `bool` | `true` | no |
| <a name="input_vault_start"></a> [vault\_start](#input\_vault\_start) | if vault should be started | `bool` | `false` | no |
| <a name="input_vault_storage_raft_cluster_member_this"></a> [vault\_storage\_raft\_cluster\_member\_this](#input\_vault\_storage\_raft\_cluster\_member\_this) | the actual instance to be excluded for the [retry\_join-stanza](https://www.vaultproject.io/docs/configuration/storage/raft#retry_join-stanza)s | `string` | `null` | no |
| <a name="input_vault_storage_raft_cluster_members"></a> [vault\_storage\_raft\_cluster\_members](#input\_vault\_storage\_raft\_cluster\_members) | the list of cluster members for the [retry\_join-stanza](https://www.vaultproject.io/docs/configuration/storage/raft#retry_join-stanza)s | `list(string)` | `[]` | no |
| <a name="input_vault_storage_raft_leader_ca_cert_file"></a> [vault\_storage\_raft\_leader\_ca\_cert\_file](#input\_vault\_storage\_raft\_leader\_ca\_cert\_file) | the [leader\_ca\_cert\_file](https://www.vaultproject.io/docs/configuration/storage/raft#leader_ca_cert_file) | `string` | `null` | no |
| <a name="input_vault_storage_raft_leader_client_cert_file"></a> [vault\_storage\_raft\_leader\_client\_cert\_file](#input\_vault\_storage\_raft\_leader\_client\_cert\_file) | the [leader\_client\_cert\_file](https://www.vaultproject.io/docs/configuration/storage/raft#leader_client_cert_file) | `string` | `null` | no |
| <a name="input_vault_storage_raft_leader_client_key_file"></a> [vault\_storage\_raft\_leader\_client\_key\_file](#input\_vault\_storage\_raft\_leader\_client\_key\_file) | the [leader\_client\_key\_file](https://www.vaultproject.io/docs/configuration/storage/raft#leader_client_key_file) | `string` | `null` | no |
| <a name="input_vault_storage_raft_node_id"></a> [vault\_storage\_raft\_node\_id](#input\_vault\_storage\_raft\_node\_id) | the `node_id` value for `storage "raft"` | `string` | `null` | no |
| <a name="input_vault_storage_raft_path"></a> [vault\_storage\_raft\_path](#input\_vault\_storage\_raft\_path) | the `path` value for `storage "raft"` | `string` | `"/srv/vault/file/raft"` | no |
| <a name="input_vault_storage_raft_retry_join_api_port"></a> [vault\_storage\_raft\_retry\_join\_api\_port](#input\_vault\_storage\_raft\_retry\_join\_api\_port) | the port number for the [leader\_api\_addr](https://developer.hashicorp.com/vault/docs/configuration/storage/raft#leader_api_addr) in the [retry\_join-stanza](https://www.vaultproject.io/docs/configuration/storage/raft#retry_join-stanza)s | `number` | `8200` | no |
| <a name="input_vault_tls_cert_file"></a> [vault\_tls\_cert\_file](#input\_vault\_tls\_cert\_file) | the path of the certificate for TLS ([tls\_cert\_file](https://www.vaultproject.io/docs/configuration/listener/tcp#tls_cert_file)<br>    default is [vault\_storage\_raft\_leader\_client\_cert\_file](#input\_vault\_storage\_raft\_leader\_client\_cert\_file) (coded in terraform) | `string` | `null` | no |
| <a name="input_vault_tls_client_ca_file"></a> [vault\_tls\_client\_ca\_file](#input\_vault\_tls\_client\_ca\_file) | the [tls\_client\_ca\_file](https://www.vaultproject.io/docs/configuration/listener/tcp#tls_client_ca_file)<br>    default is [vault\_storage\_raft\_leader\_ca\_cert\_file](#input\_vault\_storage\_raft\_leader\_ca\_cert\_file) (coded in terraform) | `string` | `null` | no |
| <a name="input_vault_tls_files"></a> [vault\_tls\_files](#input\_vault\_tls\_files) | the vault tls files<br>    - filename can contain the placeholders<br>      - $vault\_tls\_cert\_file<br>      - $vault\_tls\_key\_file<br>      - $vault\_tls\_client\_ca\_file<br>    which are replace by the corresponding terraform variables<br>  - encoding of the content can be 'text/plain' (default) or 'base64' | <pre>list(object({<br>    file_name = string,<br>    content   = string,<br>    encoding  = optional(string, "text/plain")<br>    owner     = optional(string, "vault")<br>    group     = optional(string, "vault")<br>    mode      = optional(string, "640")<br>  }))</pre> | `[]` | no |
| <a name="input_vault_tls_key_file"></a> [vault\_tls\_key\_file](#input\_vault\_tls\_key\_file) | the path of the private key for the certificate for TLS ([tls\_key\_file](https://www.vaultproject.io/docs/configuration/listener/tcp#tls_key_file))<br>    default is [vault\_storage\_raft\_leader\_client\_key\_file](#input\_vault\_storage\_raft\_leader\_client\_key\_file) (coded in terraform) | `string` | `null` | no |
| <a name="input_vault_ui"></a> [vault\_ui](#input\_vault\_ui) | if the vault user interface should be activated | `bool` | `false` | no |
| <a name="input_vault_version"></a> [vault\_version](#input\_vault\_version) | the vault version to be installed | `string` | `null` | no |
| <a name="input_wait_until"></a> [wait\_until](#input\_wait\_until) | if cloud-init user data for installing [wait\_until](https://github.com/l-with/wait-until) should be generated | `bool` | `false` | no |
| <a name="input_write_file"></a> [write\_file](#input\_write\_file) | if files should be written | `bool` | `false` | no |
| <a name="input_write_files"></a> [write\_files](#input\_write\_files) | the files to be written<br>  - encoding of the content can be 'text/plain' (default) or 'base64' | <pre>list(object({<br>    file_name = string,<br>    content   = string,<br>    encoding  = optional(string, "text/plain")<br>    owner     = optional(string, "root")<br>    group     = optional(string, "root")<br>    mode      = optional(string, "644")<br>  }))</pre> | `[]` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_init"></a> [cloud\_init](#output\_cloud\_init) | the cloud-init user data |
| <a name="output_vault"></a> [vault](#output\_vault) | the relevant results from vault install and init |
<!-- END_TF_DOCS -->
