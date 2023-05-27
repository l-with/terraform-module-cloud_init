locals {
  terraform_binary_paths = {
    apt    = "/usr/bin",
    binary = "/usr/local/bin"
  }
  terraform = merge(
    {
      runcmd = !local.parts_active.terraform ? [] : [
        {
          template = "${path.module}/templates/terraform/${local.yml_runcmd}_${var.terraform_install_method}_install.tpl",
          vars     = {}
        },
      ],
    },
  )
}
