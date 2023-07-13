locals {
  duplicacy = merge(
    {
      runcmd = !local.parts_active.duplicacy ? [] : [
        {
          template = "${path.module}/templates/duplicacy/${local.yml_runcmd}_install.tpl",
          vars = {
            duplicacy_path    = var.duplicacy_path,
            duplicacy_version = var.duplicacy_version,
          }
        },
      ],
    },
  )
}
