# Terraform Modul cloud_init

Terraform module to template cloud-init user data

## Disclaimer

currently only tested with Ubuntu focal

## Features

### certbot

s. [certbot](https://eff-certbot.readthedocs.io/en/stable/install.html#installation)

input variables:
- [certbot](#input_certbot)
- [certbot_dns_hetzner](#input_certbot_dns_hetzner)

### croc

s. [croc](https://github.com/schollz/croc#install)

input variables:
- [croc](#input_croc)

### docker

s. [docker](https://docs.docker.com/engine/install/ubuntu/)

input variables:
- [docker](#input_docker)
- [docker_vars](#input_docker_vars)

### fail2ban

s. [fail2ban](https://www.fail2ban.org/wiki/index.php/Downloads)

input variables:
- [fail2ban](#input_fail2ban)
- [fail2ban_recidive](#input_fail2ban_recidive)
- [fail2ban_sshd](#input_fail2ban_sshd)

### gettext_base

s. [gettext-base](https://packages.ubuntu.com/search?suite=default&section=all&arch=any&keywords=gettext-base&searchon=names)

input variables:
- [gettext_base](#input_gettext_base)

### jq

s. [jq](https://stedolan.github.io/jq/)

input variables:
- [jq](#input_jq)

### package

s. [package](https://cloudinit.readthedocs.io/en/latest/reference/modules.html#package-update-upgrade-install)

input variables:
- [package_reboot_if_required](#input_package_reboot_if_required)
- [package_update](#input_package_update)
- [package_upgrade](#input_package_upgrade)

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


input variables:
- [rke2_node_1st](#input_rke2_node_1st)
- [rke2_node_other](#input_rke2_rke2_node_other)
- [rke2_node_cert_package_url](#input_rke2_node_cert_package_url)
- [rke2_node_cert_package_api_header](#input_rke2_node_cert_package_api_header)
- [rke2_node_cert_package_secret](#input_rke2_node_cert_package_secret)
- [rke2_node_pre_shared_secret](#input_rke2_node_pre_shared_secret)
- [rke2_node_1st_cert_manager_crd_version](#input_rke2_node_1st_cert_manager_crd_version)
- [rke2_node_1st_rke2_role_id](#input_rke2_node_1st_rke2_role_id)
- [rke2_node_1st_rke2_secret_id](#input_rke2_node_1st_rke2_secret_id)
- [rke2_node_1st_vault_addr](#input_rke2_node_1st_vault_addr)
- [rke2_node_1st_vault_field](#input_rke2_node_1st_vault_field)
- [rke2_node_1st_vault_mount](#input_rke2_node_1st_vault_mount)
- [rke2_node_1st_vault_path](#input_rke2_node_1st_vault_path)
- [rke2_node_other_vars](#input_rke2_rke2_node_other_vars)

### vault

s. [vault](https://developer.hashicorp.com/vault/downloads)

input variables:
- [vault](#input_vault)

## terraform

<!-- BEGIN_TF_DOCS -->
#### Requirements

No requirements.

#### Providers

No providers.

#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_either_rke2_node_1st_or_rke2_node_other"></a> [either\_rke2\_node\_1st\_or\_rke2\_node\_other](#module\_either\_rke2\_node\_1st\_or\_rke2\_node\_other) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_1st_needs_rke2_node_1st_rke2_role_id"></a> [rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_role\_id](#module\_rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_role\_id) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_1st_needs_rke2_node_1st_rke2_secret_id"></a> [rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_secret\_id](#module\_rke2\_node\_1st\_needs\_rke2\_node\_1st\_rke2\_secret\_id) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_1st_needs_vault_addr"></a> [rke2\_node\_1st\_needs\_vault\_addr](#module\_rke2\_node\_1st\_needs\_vault\_addr) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_cert_package_api_header"></a> [rke2\_node\_needs\_rke2\_node\_cert\_package\_api\_header](#module\_rke2\_node\_needs\_rke2\_node\_cert\_package\_api\_header) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_cert_package_url"></a> [rke2\_node\_needs\_rke2\_node\_cert\_package\_url](#module\_rke2\_node\_needs\_rke2\_node\_cert\_package\_url) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_pre_shared_secret"></a> [rke2\_node\_needs\_rke2\_node\_pre\_shared\_secret](#module\_rke2\_node\_needs\_rke2\_node\_pre\_shared\_secret) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_rke2_node_cert_package_secret"></a> [rke2\_node\_needs\_rke2\_node\_rke2\_node\_cert\_package\_secret](#module\_rke2\_node\_needs\_rke2\_node\_rke2\_node\_cert\_package\_secret) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_other_needs_rke2_node_other_node_1st_ip"></a> [rke2\_node\_other\_needs\_rke2\_node\_other\_node\_1st\_ip](#module\_rke2\_node\_other\_needs\_rke2\_node\_other\_node\_1st\_ip) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |

#### Resources

No resources.

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certbot"></a> [certbot](#input\_certbot) | if cloud-init user data for installing certbot should be generated | `bool` | `false` | no |
| <a name="input_certbot_dns_hetzner"></a> [certbot\_dns\_hetzner](#input\_certbot\_dns\_hetzner) | if cloud-init user data for installing with certbot-dns-hetzner should be generated | `bool` | `false` | no |
| <a name="input_croc"></a> [croc](#input\_croc) | if cloud-init user data for installing croc should be generated | `bool` | `false` | no |
| <a name="input_docker"></a> [docker](#input\_docker) | if cloud-init user data for installing docker should be generated | `bool` | `false` | no |
| <a name="input_docker_manipulate_iptables"></a> [docker\_manipulate\_iptables](#input\_docker\_manipulate\_iptables) | if docker manipulate ip-tables should _not_ be generated for cloud-init user data for docker | `bool` | `true` | no |
| <a name="input_fail2ban"></a> [fail2ban](#input\_fail2ban) | if cloud-init user data for installing fail2ban should be generated | `bool` | `false` | no |
| <a name="input_fail2ban_recidive"></a> [fail2ban\_recidive](#input\_fail2ban\_recidive) | if recidive jail install should be generated | `bool` | `true` | no |
| <a name="input_fail2ban_sshd"></a> [fail2ban\_sshd](#input\_fail2ban\_sshd) | if sshd jail install should be generated | `bool` | `true` | no |
| <a name="input_gettext_base"></a> [gettext\_base](#input\_gettext\_base) | if cloud-init user data for installing gettext-base should be generated | `bool` | `false` | no |
| <a name="input_jq"></a> [jq](#input\_jq) | if cloud-init user data for installing jq should be generated | `bool` | `false` | no |
| <a name="input_nginx"></a> [nginx](#input\_nginx) | if cloud-init user data for installing nginx should be generated | `bool` | `false` | no |
| <a name="input_nginx_configuration_home"></a> [nginx\_configuration\_home](#input\_nginx\_configuration\_home) | the nginx configuration home for cloud-init user data for nginx | `string` | `"/etc/nginx"` | no |
| <a name="input_nginx_confs"></a> [nginx\_confs](#input\_nginx\_confs) | the extra configurations for nginx for cloud-init user data for nginx | <pre>list(object({<br>    port        = number // the port for `listen`<br>    server_name = string // the server_name for `server_name`<br>    fqdn        = string // the FQDN used for include Let's Encrypt certificates: `/etc/letsencrypt/live/{{ nginx_conf.FQDN }}/...`<br>    nginx_conf  = string // the configuration to be included in the `sever` stanza<br>  }))</pre> | `[]` | no |
| <a name="input_nginx_gnu"></a> [nginx\_gnu](#input\_nginx\_gnu) | if the [GNU Terry Pratchett](http://www.gnuterrypratchett.com) header should be inserted for cloud-init user data for nginx | `bool` | `true` | no |
| <a name="input_nginx_https_conf"></a> [nginx\_https\_conf](#input\_nginx\_https\_conf) | the nginx https configuration after `server_name` for cloud-init user data for nginx | `string` | n/a | yes |
| <a name="input_nginx_server_fqdn"></a> [nginx\_server\_fqdn](#input\_nginx\_server\_fqdn) | the FQDN of the server for nginx server\_name and Let's Encrypt certificates for cloud-init user data for nginx | `string` | n/a | yes |
| <a name="input_package_reboot_if_required"></a> [package\_reboot\_if\_required](#input\_package\_reboot\_if\_required) | if cloud-init user data for package\_reboot\_if\_required should be generated | `bool` | `false` | no |
| <a name="input_package_update"></a> [package\_update](#input\_package\_update) | if cloud-init user data for package\_update should be generated | `bool` | `true` | no |
| <a name="input_package_upgrade"></a> [package\_upgrade](#input\_package\_upgrade) | if cloud-init user data for package\_upgrade should be generated | `bool` | `true` | no |
| <a name="input_rke2_node_1st"></a> [rke2\_node\_1st](#input\_rke2\_node\_1st) | if cloud-init user data for the rke2 1st node should be generated | `bool` | `false` | no |
| <a name="input_rke2_node_1st_cert_manager_crd_version"></a> [rke2\_node\_1st\_cert\_manager\_crd\_version](#input\_rke2\_node\_1st\_cert\_manager\_crd\_version) | the version of cert-manager CRDs to be installed | `string` | `"1.11.0"` | no |
| <a name="input_rke2_node_1st_rke2_role_id"></a> [rke2\_node\_1st\_rke2\_role\_id](#input\_rke2\_node\_1st\_rke2\_role\_id) | the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault | `string` | `""` | no |
| <a name="input_rke2_node_1st_rke2_secret_id"></a> [rke2\_node\_1st\_rke2\_secret\_id](#input\_rke2\_node\_1st\_rke2\_secret\_id) | the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault | `string` | `""` | no |
| <a name="input_rke2_node_1st_vault_addr"></a> [rke2\_node\_1st\_vault\_addr](#input\_rke2\_node\_1st\_vault\_addr) | the vault address to put the `ke2.yml`  as kv into | `string` | `""` | no |
| <a name="input_rke2_node_1st_vault_field"></a> [rke2\_node\_1st\_vault\_field](#input\_rke2\_node\_1st\_vault\_field) | the vault field used to put the `rke2.yaml` as kv into vault | `string` | `"rke2_yaml"` | no |
| <a name="input_rke2_node_1st_vault_mount"></a> [rke2\_node\_1st\_vault\_mount](#input\_rke2\_node\_1st\_vault\_mount) | the vault mount used to put the `rke2.yaml` as kv into vault | `string` | `"gitlab"` | no |
| <a name="input_rke2_node_1st_vault_path"></a> [rke2\_node\_1st\_vault\_path](#input\_rke2\_node\_1st\_vault\_path) | the vault path used to put the `rke2.yaml` as kv into vault | `string` | `"rancher/kubeconfig"` | no |
| <a name="input_rke2_node_cert_package_api_header"></a> [rke2\_node\_cert\_package\_api\_header](#input\_rke2\_node\_cert\_package\_api\_header) | the header to authorize getting the cert-package | `string` | `""` | no |
| <a name="input_rke2_node_cert_package_secret"></a> [rke2\_node\_cert\_package\_secret](#input\_rke2\_node\_cert\_package\_secret) | the secret to decrypt the cert package (`openssl enc -aes-256-cbc -pbkdf2)` | `string` | `""` | no |
| <a name="input_rke2_node_cert_package_url"></a> [rke2\_node\_cert\_package\_url](#input\_rke2\_node\_cert\_package\_url) | the url to get the cert-package from | `string` | `""` | no |
| <a name="input_rke2_node_other"></a> [rke2\_node\_other](#input\_rke2\_node\_other) | if cloud-init user data for the rke2 other nodes should be generated | `bool` | `false` | no |
| <a name="input_rke2_node_other_node_1st_ip"></a> [rke2\_node\_other\_node\_1st\_ip](#input\_rke2\_node\_other\_node\_1st\_ip) | the ip of the 1st node for cloud-init user data for rke2 other nodes | `string` | `""` | no |
| <a name="input_rke2_node_pre_shared_secret"></a> [rke2\_node\_pre\_shared\_secret](#input\_rke2\_node\_pre\_shared\_secret) | the pre shared secret for `/etc/rancher/rke2/config.yaml` | `string` | `""` | no |
| <a name="input_vault"></a> [vault](#input\_vault) | if cloud-init user data for installing vault should be generated | `bool` | `false` | no |
| <a name="input_vault_addr"></a> [vault\_addr](#input\_vault\_addr) | the vault address (can be used as default for other features) | `string` | `""` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_init"></a> [cloud\_init](#output\_cloud\_init) | the cloud-init user data |
<!-- END_TF_DOCS -->
