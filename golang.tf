locals {
  golang = !local.parts_active.golang ? {} : {
    runcmd = concat([{
      template = "${path.module}/templates/${local.yml_runcmd}_packages.tpl",
      vars = {
        packages = "golang"
      }
      }],
      [
        for golang_tool in var.golang_tools :
        {
          template = "${path.module}/templates/${local.yml_runcmd}_runcmd.tpl",
          vars = {
            runcmd_script = "  - GOPATH=/root/go go install ${golang_tool}"
          }
        }
      ]
    )
  }
}
