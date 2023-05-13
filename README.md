# Terraform Modul cloud_init

Terraform module to template cloud-init user data

## Disclaimer

currently only tested with Ubuntu focal

## Features

### b2

s. [B2 Command Line Tool](https://github.com/Backblaze/B2_Command_Line_Tool/releases)

For input variables: s. [b2](#input_b2).

### certbot

s. [certbot](https://eff-certbot.readthedocs.io/en/stable/install.html#installation)

For input variables: s. [certbot](#input_certbot).

### croc

s. [croc](https://github.com/schollz/croc#install)

For input variables: s. [croc](#input_croc).

### docker

s. [docker](https://docs.docker.com/engine/install/ubuntu/)

For input variables: s. [docker](#input_docker).

### docker_container

s. [docker](https://docs.docker.com/engine/reference/run/)

For input variables: s. [docker_container](#input_docker_container).

### encrypted packages

For input variables: s. [encrypted_packages](#input_encrypted_packages).

### fail2ban

s. [fail2ban](https://www.fail2ban.org/wiki/index.php/Downloads)

For input variables: s. [fail2ban](#input_fail2ban).

### gettext_base

s. [gettext-base](https://packages.ubuntu.com/search?suite=default&section=all&arch=any&keywords=gettext-base&searchon=names)

For input variables: s. [gettext_base](#input_gettext_base).

### jq

s. [jq](https://stedolan.github.io/jq/)

For input variables: s. [jq](#input_jq).

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

### s3cmd

s. [S3cmd](https://github.com/s3tools/s3cmd)

For input variables: s. [s3cmd](#input_s3cmd).

### vault

s. [vault](https://developer.hashicorp.com/vault/downloads)

For input variables: s. [vault](#input_vault).

### wait_until

s. [wait_until](https://github.com/l-with/wait-until)

For input variables: s. [wait_until](#wait_until).

## terraform

<!-- BEGIN_TF_DOCS -->
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

#### Providers

No providers.

#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_init_part"></a> [cloud\_init\_part](#module\_cloud\_init\_part) | ./modules/cloud_init_part | n/a |
| <a name="module_either_rke2_node_1st_or_rke2_node_other"></a> [either\_rke2\_node\_1st\_or\_rke2\_node\_other](#module\_either\_rke2\_node\_1st\_or\_rke2\_node\_other) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_1st_needs_rke2_node_1st_rke2_role_id"></a> [rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_role\_id](#module\_rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_role\_id) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_1st_needs_rke2_node_1st_rke2_secret_id"></a> [rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_secret\_id](#module\_rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_secret\_id) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_1st_needs_vault_addr"></a> [rke2\_node\_1st\_needs\_vault\_addr](#module\_rke2\_node\_1st\_needs\_vault\_addr) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_encrypted_package_api_header"></a> [rke2\_node\_needs\_encrypted\_package\_api\_header](#module\_rke2\_node\_needs\_encrypted\_package\_api\_header) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_cert_package_url"></a> [rke2\_node\_needs\_rke2\_node\_cert\_package\_url](#module\_rke2\_node\_needs\_rke2\_node\_cert\_package\_url) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_pre_shared_secret"></a> [rke2\_node\_needs\_rke2\_node\_pre\_shared\_secret](#module\_rke2\_node\_needs\_rke2\_node\_pre\_shared\_secret) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_rke2_node_cert_package_secret"></a> [rke2\_node\_needs\_rke2\_node\_rke2\_node\_cert\_package\_secret](#module\_rke2\_node\_needs\_rke2\_node\_rke2\_node\_cert\_package\_secret) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_other_needs_rke2_node_other_node_1st_ip"></a> [rke2\_node\_other\_needs\_rke2\_node\_other\_node\_1st\_ip](#module\_rke2\_node\_other\_needs\_rke2\_node\_other\_node\_1st\_ip) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_vault_init_needs_vault_init_addr"></a> [vault\_init\_needs\_vault\_init\_addr](#module\_vault\_init\_needs\_vault\_init\_addr) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_vault_init_needs_vault_init_s3cfg"></a> [vault\_init\_needs\_vault\_init\_s3cfg](#module\_vault\_init\_needs\_vault\_init\_s3cfg) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_vault_init_needs_vault_vault_init_encrypt_secret"></a> [vault\_init\_needs\_vault\_vault\_init\_encrypt\_secret](#module\_vault\_init\_needs\_vault\_vault\_init\_encrypt\_secret) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |

#### Resources

No resources.

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_b2"></a> [b2](#input\_b2) | if cloud-init user data for installing the [BlackBlaze CLI](https://www.backblaze.com/b2/docs/quick_command_line.html) should be generated | `bool` | `false` | no |
| <a name="input_certbot"></a> [certbot](#input\_certbot) | if cloud-init user data for installing certbot should be generated | `bool` | `false` | no |
| <a name="input_certbot_dns_hetzner"></a> [certbot\_dns\_hetzner](#input\_certbot\_dns\_hetzner) | if cloud-init user data for installing with certbot-dns-hetzner should be generated | `bool` | `false` | no |
| <a name="input_croc"></a> [croc](#input\_croc) | if cloud-init user data for installing croc should be generated | `bool` | `false` | no |
| <a name="input_docker"></a> [docker](#input\_docker) | if cloud-init user data for installing docker should be generated | `bool` | `false` | no |
| <a name="input_docker_container"></a> [docker\_container](#input\_docker\_container) | if cloud-init user data for installing docker containers should be generated | `bool` | `false` | no |
| <a name="input_docker_container_list"></a> [docker\_container\_list](#input\_docker\_container\_list) | the docker containers the cloud-init user data should be generated for | <pre>list(object({<br>    name           = string // --name<br>    image          = string<br>    ports          = string // --publish<br>    command        = string<br>    restart_policy = string // --restart<br>  }))</pre> | `[]` | no |
| <a name="input_docker_manipulate_iptables"></a> [docker\_manipulate\_iptables](#input\_docker\_manipulate\_iptables) | if docker manipulate ip-tables should _not_ be generated for cloud-init user data for docker | `bool` | `true` | no |
| <a name="input_encrypted_packages"></a> [encrypted\_packages](#input\_encrypted\_packages) | if cloud-init user data for the encrypted packages should be generated | `bool` | `false` | no |
| <a name="input_encrypted_packages_list"></a> [encrypted\_packages\_list](#input\_encrypted\_packages\_list) | the encrypted packages the cloud-init user data should be generated for | <pre>list(object({<br>    url        = string                 // the url to get the package from<br>    api_header = string                 // the header to authorize getting the package<br>    secret     = string                 // the secret to decrypt the package (`openssl enc -aes-256-cbc -pbkdf2`)"<br>    post_cmd   = optional(string, null) // the command to be executed after the installing the package<br>  }))</pre> | `[]` | no |
| <a name="input_fail2ban"></a> [fail2ban](#input\_fail2ban) | if cloud-init user data for installing fail2ban should be generated | `bool` | `false` | no |
| <a name="input_fail2ban_recidive"></a> [fail2ban\_recidive](#input\_fail2ban\_recidive) | if recidive jail install should be generated | `bool` | `true` | no |
| <a name="input_fail2ban_sshd"></a> [fail2ban\_sshd](#input\_fail2ban\_sshd) | if sshd jail install should be generated | `bool` | `true` | no |
| <a name="input_gettext_base"></a> [gettext\_base](#input\_gettext\_base) | if cloud-init user data for installing gettext-base should be generated | `bool` | `false` | no |
| <a name="input_jq"></a> [jq](#input\_jq) | if cloud-init user data for installing jq should be generated | `bool` | `false` | no |
| <a name="input_mailcow"></a> [mailcow](#input\_mailcow) | if cloud-init user data for installing mailcow should be generated | `bool` | `false` | no |
| <a name="input_mailcow_install_path"></a> [mailcow\_install\_path](#input\_mailcow\_install\_path) | the install path for mailcow | `string` | `"/opt/mailcow-dockerized"` | no |
| <a name="input_mailcow_version"></a> [mailcow\_version](#input\_mailcow\_version) | the branch value for mailcow (`MAILCOW_BRANCH`) | `string` | `"master"` | no |
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
| <a name="input_python3_pip"></a> [python3\_pip](#input\_python3\_pip) | if cloud-init user data for installing python3-pip should be generated | `bool` | `false` | no |
| <a name="input_rke2"></a> [rke2](#input\_rke2) | if cloud-init user data for the rke2 should be generated | `bool` | `false` | no |
| <a name="input_rke2_node_1st"></a> [rke2\_node\_1st](#input\_rke2\_node\_1st) | if cloud-init user data for the rke2 1st node should be generated | `bool` | `false` | no |
| <a name="input_rke2_node_1st_cert_manager_crd_version"></a> [rke2\_node\_1st\_cert\_manager\_crd\_version](#input\_rke2\_node\_1st\_cert\_manager\_crd\_version) | the version of cert-manager CRDs to be installed | `string` | `"1.11.0"` | no |
| <a name="input_rke2_node_1st_rke2_role_id"></a> [rke2\_node\_1st\_rke2\_role\_id](#input\_rke2\_node\_1st\_rke2\_role\_id) | the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault | `string` | `null` | no |
| <a name="input_rke2_node_1st_rke2_secret_id"></a> [rke2\_node\_1st\_rke2\_secret\_id](#input\_rke2\_node\_1st\_rke2\_secret\_id) | the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault | `string` | `null` | no |
| <a name="input_rke2_node_1st_vault_addr"></a> [rke2\_node\_1st\_vault\_addr](#input\_rke2\_node\_1st\_vault\_addr) | the vault address to put the `ke2.yml`  as kv into | `string` | `null` | no |
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
| <a name="input_s3cmd"></a> [s3cmd](#input\_s3cmd) | if cloud-init user data for installing the [S3cmd](https://github.com/s3tools/s3cmd) should be generated | `bool` | `false` | no |
| <a name="input_vault"></a> [vault](#input\_vault) | if cloud-init user data for installing vault should be generated | `bool` | `false` | no |
| <a name="input_vault_addr"></a> [vault\_addr](#input\_vault\_addr) | the vault address (can be used as default for other features) | `string` | `null` | no |
| <a name="input_vault_api_addr"></a> [vault\_api\_addr](#input\_vault\_api\_addr) | the [api\_addr](https://www.vaultproject.io/docs/configuration#api_addr)<br>    the string '$ipv4\_address' can be used as placeholder for the server ipv4-address | `string` | `"http://$ipv4_address:8200"` | no |
| <a name="input_vault_api_port"></a> [vault\_api\_port](#input\_vault\_api\_port) | the vault api port (for [api\_addr](https://www.vaultproject.io/docs/configuration#api_addr) and [address](https://www.vaultproject.io/docs/configuration/listener/tcp#address)) | `number` | `8200` | no |
| <a name="input_vault_cluster_addr"></a> [vault\_cluster\_addr](#input\_vault\_cluster\_addr) | the [cluster\_addr](https://www.vaultproject.io/docs/configuration#cluster_addr)<br>    the string '$ipv4\_address' can be used as placeholder for the server ipv4-address | `string` | `"http://$ipv4_address:8201"` | no |
| <a name="input_vault_cluster_port"></a> [vault\_cluster\_port](#input\_vault\_cluster\_port) | the vault cluster port (for [cluster\_addr](https://www.vaultproject.io/docs/configuration#cluster_addr) and [cluster\_address](https://www.vaultproject.io/docs/configuration/listener/tcp#cluster_address)) | `number` | `8201` | no |
| <a name="input_vault_config_path"></a> [vault\_config\_path](#input\_vault\_config\_path) | the path for the vault configuration files | `string` | `"/etc/vault.d"` | no |
| <a name="input_vault_disable_mlock"></a> [vault\_disable\_mlock](#input\_vault\_disable\_mlock) | the value for [disable\_mlock](https://www.vaultproject.io/docs/configuration#disable_mlock) | `bool` | `true` | no |
| <a name="input_vault_home_path"></a> [vault\_home\_path](#input\_vault\_home\_path) | the home of the vault specific files and folders | `string` | `"/srv/vault"` | no |
| <a name="input_vault_init"></a> [vault\_init](#input\_vault\_init) | if vault should be initialized | `bool` | `true` | no |
| <a name="input_vault_init_addr"></a> [vault\_init\_addr](#input\_vault\_init\_addr) | the vault address used for `vault init` during cloud init | `string` | `null` | no |
| <a name="input_vault_init_artifact"></a> [vault\_init\_artifact](#input\_vault\_init\_artifact) | the filename for the openssl encrypted output from `vault init` | `string` | `"vault_init.tgz.enc"` | no |
| <a name="input_vault_init_encrypt_secret"></a> [vault\_init\_encrypt\_secret](#input\_vault\_init\_encrypt\_secret) | the secret the output of the vault initialization is encoded with<br /> <span style="color:red">ATTENTION: Keep this confidential! This is the root of the secret management in vault.</span> | `string` | `null` | no |
| <a name="input_vault_init_s3cfg"></a> [vault\_init\_s3cfg](#input\_vault\_init\_s3cfg) | the values for the [S3cmd](https://s3tools.org/usage)<br>        s3cmd --access\_key=<access\_key> --secret\_key=<secret\_key>} \<br>        --host=https://<host\_base> '--host-bucket=\%(bucket)s.<host\_base>' \<br>        put FILE s3://<bucket>\%\{if prefix != null\}/<prefix>\%\{ endif \} | <pre>object({<br>    access_key = string,<br>    secret_key = string,<br>    host_base  = string,<br>    bucket     = string,<br>    prefix     = optional(string, null),<br>  })</pre> | `null` | no |
| <a name="input_vault_install_method"></a> [vault\_install\_method](#input\_vault\_install\_method) | the install method, supported methods are 'apt' | `string` | `"apt"` | no |
| <a name="input_vault_key_shares"></a> [vault\_key\_shares](#input\_vault\_key\_shares) | the number of [key shares](https://developer.hashicorp.com/vault/docs/commands/operator/init#key-shares) | `number` | `1` | no |
| <a name="input_vault_key_threshold"></a> [vault\_key\_threshold](#input\_vault\_key\_threshold) | the number of key shares required to reconstruct the root key (s. https://developer.hashicorp.com/vault/docs/commands/operator/init#key-threshold) | `number` | `1` | no |
| <a name="input_vault_listeners"></a> [vault\_listeners](#input\_vault\_listeners) | the list of [listener](https://www.vaultproject.io/docs/configuration/listener/tcp)s<br>    the default for each (coded in terraform)<br>      - tls\_cert\_file is [vault\_tls\_cert\_file](#input\_vault\_tls\_cert\_file)<br>      - tls\_key\_file is [vault\_tls\_key\_file](#input\_vault\_tls\_key\_file)<br>      - tls\_client\_ca\_file [vault\_tls\_client\_ca\_file](#input\_vault\_tls\_client\_ca\_file) | <pre>list(object({<br>    address            = string,<br>    cluster_address    = optional(string, null),<br>    tls_disable        = optional(bool, true),<br>    tls_cert_file      = optional(string, null),<br>    tls_key_file       = optional(string, null),<br>    tls_client_ca_file = optional(string, null),<br>  }))</pre> | `[]` | no |
| <a name="input_vault_log_level"></a> [vault\_log\_level](#input\_vault\_log\_level) | the [vault log level](https://www.vaultproject.io/docs/configuration#log_level) | `string` | `"info"` | no |
| <a name="input_vault_raft_leader_tls_servername"></a> [vault\_raft\_leader\_tls\_servername](#input\_vault\_raft\_leader\_tls\_servername) | the [leader\_tls\_servername](https://www.vaultproject.io/docs/configuration/storage/raft#leader_tls_servername) | `string` | `null` | no |
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
| <a name="input_vault_tls_key_file"></a> [vault\_tls\_key\_file](#input\_vault\_tls\_key\_file) | the path of the private key for the certificate for TLS ([tls\_key\_file](https://www.vaultproject.io/docs/configuration/listener/tcp#tls_key_file))<br>    default is [vault\_storage\_raft\_leader\_client\_key\_file](#input\_vault\_storage\_raft\_leader\_client\_key\_file) (coded in terraform) | `string` | `null` | no |
| <a name="input_vault_ui"></a> [vault\_ui](#input\_vault\_ui) | if the vault user interface should be activated | `bool` | `false` | no |
| <a name="input_wait_until"></a> [wait\_until](#input\_wait\_until) | if cloud-init user data for installing wait\_until should be generated | `bool` | `false` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_init"></a> [cloud\_init](#output\_cloud\_init) | the cloud-init user data |
<!-- END_TF_DOCS -->
