# Terraform Modul cloud-init

Terraform module to template cloud-init user data

## Disclaimer

currently only tested with Ubuntu focal

## Features

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
- for the 1st master
- for the other masters

The certificates for RKE2 are fetched from a package registry 
and decrypted with openssl and thus have to pre pre-built.
The package also has to contain templates for `/etc/rancher/rke2/config.yaml`:

- `/root/config.yaml.master1.envtpl` for the first master
- `/root/config.yaml.envtpl` for the other masters

The [cert-manager](https://github.com/cert-manager/cert-manager) `cert-manager.crds.yaml` 
is pre-installed as manifest in the 1st master.


input variables:
- [rke2_master_1st](#input_rke2_master_1st)
- [rke2_master_1st_cert_manager_crd_version](#input_rke2_master_1st_cert_manager_crd_version)
- [rke2_master_1st_rke2_role_id](#input_rke2_master_1st_rke2_role_id)
- [rke2_master_1st_rke2_secret_id](#input_rke2_master_1st_rke2_secret_id)
- [rke2_master_1st_vault_addr](#input_rke2_master_1st_vault_addr)
- [rke2_master_1st_vault_field](#input_rke2_master_1st_vault_field)
- [rke2_master_1st_vault_mount](#input_rke2_master_1st_vault_mount)
- [rke2_master_1st_vault_path](#input_rke2_master_1st_vault_path)
- [rke2_master_other](#input_rke2_rke2_master_other)
- [rke2_master_other_vars](#input_rke2_rke2_master_other_vars)
- [rke2_master_vars](#input_rke2_rke2_master_vars)

### vault

s. [vault](https://developer.hashicorp.com/vault/downloads)

input variables:
- [vault](#input_vault)

## terraform

<!-- BEGIN_TF_DOCS -->
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.0 |

#### Providers

No providers.

#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_either_rke2_node_1st_or_rke2_node_other"></a> [either\_rke2\_node\_1st\_or\_rke2\_node\_other](#module\_either\_rke2\_node\_1st\_or\_rke2\_node\_other) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_1st_needs_rke2_secred_id"></a> [rke2\_node\_1st\_needs\_rke2\_secred\_id](#module\_rke2\_node\_1st\_needs\_rke2\_secred\_id) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_node_needs_rke2_node_vars"></a> [rke2\_node\_needs\_rke2\_node\_vars](#module\_rke2\_node\_needs\_rke2\_node\_vars) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |

#### Resources

No resources.

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_croc"></a> [croc](#input\_croc) | if cloud-init user data for installing croc should be generated | `bool` | `false` | no |
| <a name="input_docker"></a> [docker](#input\_docker) | if cloud-init user data for installing docker should be generated | `bool` | `false` | no |
| <a name="input_docker_vars"></a> [docker\_vars](#input\_docker\_vars) | the variables for cloud-init user data for docker | <pre>object({<br>    docker_manipulate_iptables = bool<br>  })</pre> | <pre>{<br>  "docker_manipulate_iptables": true<br>}</pre> | no |
| <a name="input_fail2ban"></a> [fail2ban](#input\_fail2ban) | if cloud-init user data for installing fail2ban should be generated | `bool` | `false` | no |
| <a name="input_fail2ban_recidive"></a> [fail2ban\_recidive](#input\_fail2ban\_recidive) | if recidive jail install should be generated | `bool` | `true` | no |
| <a name="input_fail2ban_sshd"></a> [fail2ban\_sshd](#input\_fail2ban\_sshd) | if sshd jail install should be generated | `bool` | `true` | no |
| <a name="input_fail2ban_vars"></a> [fail2ban\_vars](#input\_fail2ban\_vars) | the variables for cloud-init user data for rke2 1st and other masters | <pre>object({<br>    rke2_cert_package_url       = string<br>    rke2_cert_artifact          = string<br>    rke2_cert_package_api_token = string<br>    rke2_cert_package_secret    = string<br>    rke2_pre_shared_secret      = string<br>  })</pre> | <pre>{<br>  "rke2_cert_artifact": "",<br>  "rke2_cert_package_api_token": "",<br>  "rke2_cert_package_secret": "",<br>  "rke2_cert_package_url": "",<br>  "rke2_pre_shared_secret": ""<br>}</pre> | no |
| <a name="input_gettext_base"></a> [gettext\_base](#input\_gettext\_base) | if cloud-init user data for installing gettext-base should be generated | `bool` | `false` | no |
| <a name="input_jq"></a> [jq](#input\_jq) | if cloud-init user data for installing jq should be generated | `bool` | `false` | no |
| <a name="input_package_reboot_if_required"></a> [package\_reboot\_if\_required](#input\_package\_reboot\_if\_required) | if cloud-init user data for package\_reboot\_if\_required should be generated | `bool` | `false` | no |
| <a name="input_package_update"></a> [package\_update](#input\_package\_update) | if cloud-init user data for package\_update should be generated | `bool` | `true` | no |
| <a name="input_package_upgrade"></a> [package\_upgrade](#input\_package\_upgrade) | if cloud-init user data for package\_upgrade should be generated | `bool` | `true` | no |
| <a name="input_rke2_node_1st"></a> [rke2\_node\_1st](#input\_rke2\_node\_1st) | if cloud-init user data for the rke2 1st masters should be generated | `bool` | `false` | no |
| <a name="input_rke2_node_1st_cert_manager_crd_version"></a> [rke2\_node\_1st\_cert\_manager\_crd\_version](#input\_rke2\_node\_1st\_cert\_manager\_crd\_version) | the version of cert-manager CRDs to be installed | `string` | `"1.11.0"` | no |
| <a name="input_rke2_node_1st_rke2_role_id"></a> [rke2\_node\_1st\_rke2\_role\_id](#input\_rke2\_node\_1st\_rke2\_role\_id) | the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault | `string` | n/a | yes |
| <a name="input_rke2_node_1st_rke2_secret_id"></a> [rke2\_node\_1st\_rke2\_secret\_id](#input\_rke2\_node\_1st\_rke2\_secret\_id) | the role id for the app role in vault to login and get the token to put the `rke2.yaml` as kv into vault | `string` | n/a | yes |
| <a name="input_rke2_node_1st_vault_addr"></a> [rke2\_node\_1st\_vault\_addr](#input\_rke2\_node\_1st\_vault\_addr) | the vault address to put the `ke2.yml`  as kv into | `string` | `""` | no |
| <a name="input_rke2_node_1st_vault_field"></a> [rke2\_node\_1st\_vault\_field](#input\_rke2\_node\_1st\_vault\_field) | the vault field used to put the `rke2.yaml` as kv into vault | `string` | `"rke2_yaml"` | no |
| <a name="input_rke2_node_1st_vault_mount"></a> [rke2\_node\_1st\_vault\_mount](#input\_rke2\_node\_1st\_vault\_mount) | the vault mount used to put the `rke2.yaml` as kv into vault | `string` | `"gitlab"` | no |
| <a name="input_rke2_node_1st_vault_path"></a> [rke2\_node\_1st\_vault\_path](#input\_rke2\_node\_1st\_vault\_path) | the vault path used to put the `rke2.yaml` as kv into vault | `string` | `"rancher/kubeconfig"` | no |
| <a name="input_rke2_node_other"></a> [rke2\_node\_other](#input\_rke2\_node\_other) | if cloud-init user data for the rke2 other masters should be generated | `bool` | `false` | no |
| <a name="input_rke2_node_other_vars"></a> [rke2\_node\_other\_vars](#input\_rke2\_node\_other\_vars) | the variables for cloud-init user data for rke2 other masters | <pre>object({<br>    rke2_master1_ip = string<br>  })</pre> | <pre>{<br>  "rke2_master1_ip": ""<br>}</pre> | no |
| <a name="input_rke2_node_vars"></a> [rke2\_node\_vars](#input\_rke2\_node\_vars) | the variables for cloud-init user data for rke2 1st and other masters | <pre>object({<br>    rke2_cert_package_url        = string<br>    rke2_cert_package_api_header = string<br>    rke2_cert_package_secret     = string<br>    rke2_pre_shared_secret       = string<br>  })</pre> | <pre>{<br>  "rke2_cert_package_api_header": "",<br>  "rke2_cert_package_secret": "",<br>  "rke2_cert_package_url": "",<br>  "rke2_pre_shared_secret": ""<br>}</pre> | no |
| <a name="input_vault"></a> [vault](#input\_vault) | if cloud-init user data for installing vault should be generated | `bool` | `false` | no |
| <a name="input_vault_addr"></a> [vault\_addr](#input\_vault\_addr) | the vault address (can be used as default for other features) | `string` | `""` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_init"></a> [cloud\_init](#output\_cloud\_init) | the cloud-init user data |
<!-- END_TF_DOCS -->


<!-- BEGIN_TF_DOCS_cluster -->
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |

#### Providers

No providers.

#### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_either_rke2_master_1st_or_rke2_master_other"></a> [either\_rke2\_master\_1st\_or\_rke2\_master\_other](#module\_either\_rke2\_master\_1st\_or\_rke2\_master\_other) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_master_1st_needs_rke2_secred_id"></a> [rke2\_master\_1st\_needs\_rke2\_secred\_id](#module\_rke2\_master\_1st\_needs\_rke2\_secred\_id) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |
| <a name="module_rke2_master_needs_rke2_master_vars"></a> [rke2\_master\_needs\_rke2\_master\_vars](#module\_rke2\_master\_needs\_rke2\_master\_vars) | rhythmictech/errorcheck/terraform | ~> 1.3.0 |

#### Resources

No resources.

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_croc"></a> [croc](#input\_croc) | if cloud-init user data for installing croc should be generated | `bool` | `false` | no |
| <a name="input_docker"></a> [docker](#input\_docker) | if cloud-init user data for installing docker should be generated | `bool` | `false` | no |
| <a name="input_docker_vars"></a> [docker\_vars](#input\_docker\_vars) | the variables for cloud-init user data for docker | <pre>object({<br>    docker_manipulate_iptables = bool<br>  })</pre> | <pre>{<br>  "docker_manipulate_iptables": true<br>}</pre> | no |
| <a name="input_fail2ban"></a> [fail2ban](#input\_fail2ban) | if cloud-init user data for installing fail2ban should be generated | `bool` | `false` | no |
| <a name="input_fail2ban_recidive"></a> [fail2ban\_recidive](#input\_fail2ban\_recidive) | if recidive jail install should be generated | `bool` | `true` | no |
| <a name="input_fail2ban_sshd"></a> [fail2ban\_sshd](#input\_fail2ban\_sshd) | if sshd jail install should be generated | `bool` | `true` | no |
| <a name="input_fail2ban_vars"></a> [fail2ban\_vars](#input\_fail2ban\_vars) | the variables for cloud-init user data for rke2 1st and other masters | <pre>object({<br>    rke2_cert_package_url       = string<br>    rke2_cert_artifact          = string<br>    rke2_cert_package_api_token = string<br>    rke2_cert_package_secret    = string<br>    rke2_pre_shared_secret      = string<br>  })</pre> | <pre>{<br>  "rke2_cert_artifact": "",<br>  "rke2_cert_package_api_token": "",<br>  "rke2_cert_package_secret": "",<br>  "rke2_cert_package_url": "",<br>  "rke2_pre_shared_secret": ""<br>}</pre> | no |
| <a name="input_gettext_base"></a> [gettext\_base](#input\_gettext\_base) | if cloud-init user data for installing gettext-base should be generated | `bool` | `false` | no |
| <a name="input_jq"></a> [jq](#input\_jq) | if cloud-init user data for installing jq should be generated | `bool` | `false` | no |
| <a name="input_package_reboot_if_required"></a> [package\_reboot\_if\_required](#input\_package\_reboot\_if\_required) | if cloud-init user data for package\_reboot\_if\_required should be generated | `bool` | `false` | no |
| <a name="input_package_update"></a> [package\_update](#input\_package\_update) | if cloud-init user data for package\_update should be generated | `bool` | `true` | no |
| <a name="input_package_upgrade"></a> [package\_upgrade](#input\_package\_upgrade) | if cloud-init user data for package\_upgrade should be generated | `bool` | `true` | no |
| <a name="input_rke2_master_1st"></a> [rke2\_master\_1st](#input\_rke2\_master\_1st) | if cloud-init user data for the rke2 1st masters should be generated | `bool` | `false` | no |
| <a name="input_rke2_master_1st_vars"></a> [rke2\_master\_1st\_vars](#input\_rke2\_master\_1st\_vars) | the variables for cloud-init user data for rke2 1st master | <pre>object({<br>    rke2_role_id   = string<br>    rke2_secret_id = string<br>  })</pre> | <pre>{<br>  "rke2_role_id": "",<br>  "rke2_secret_id": ""<br>}</pre> | no |
| <a name="input_rke2_master_other"></a> [rke2\_master\_other](#input\_rke2\_master\_other) | if cloud-init user data for the rke2 other masters should be generated | `bool` | `false` | no |
| <a name="input_rke2_master_other_vars"></a> [rke2\_master\_other\_vars](#input\_rke2\_master\_other\_vars) | the variables for cloud-init user data for rke2 other masters | <pre>object({<br>    rke2_master1_ip = string<br>  })</pre> | <pre>{<br>  "rke2_master1_ip": ""<br>}</pre> | no |
| <a name="input_rke2_master_vars"></a> [rke2\_master\_vars](#input\_rke2\_master\_vars) | the variables for cloud-init user data for rke2 1st and other masters | <pre>object({<br>    rke2_cert_package_url       = string<br>    rke2_cert_artifact          = string<br>    rke2_cert_package_api_token = string<br>    rke2_cert_package_secret    = string<br>    rke2_pre_shared_secret      = string<br>  })</pre> | <pre>{<br>  "rke2_cert_artifact": "",<br>  "rke2_cert_package_api_token": "",<br>  "rke2_cert_package_secret": "",<br>  "rke2_cert_package_url": "",<br>  "rke2_pre_shared_secret": ""<br>}</pre> | no |
| <a name="input_vault"></a> [vault](#input\_vault) | if cloud-init user data for installing vault should be generated | `bool` | `false` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_init"></a> [cloud\_init](#output\_cloud\_init) | the cloud-init user data |
<!-- END_TF_DOCS_cluster -->