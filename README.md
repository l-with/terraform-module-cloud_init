# Terraform Modul cloud-init

Terraform module to template cloud-init user data

## Features

### croc

[croc](https://github.com/schollz/croc#install)

- [input croc](#input\_croc)

### docker

[docker](https://docs.docker.com/engine/install/ubuntu/)

- [input docker](#input\_docker)
- [input docker_vars](#input\_docker\_vars)

## terraform 

<!-- BEGIN_TF_DOCS -->
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