locals {
  runcmd = {
    runcmd = concat(
      [
        for index, runcmd_script in var.runcmd_scripts :
        {
          template = "${path.module}/templates/${local.yml_runcmd}_runcmd.tpl",
          vars = {
            runcmd_script = runcmd_script
          }
        }
      ],
    )
  }
}
