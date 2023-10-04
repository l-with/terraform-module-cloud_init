locals {
  zypper = {
    runcmd = !local.parts_active.zypper ? [] : [
      for index, zypper_repository in var.zypper_repositories :
      {
        template = "${path.module}/templates/zypper/${local.yml_runcmd}_addrepo.tpl",
        vars = {
          uri   = zypper_repository.uri,
          alias = zypper_repository.alias,
        },
      }
    ],
  }
}
