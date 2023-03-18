locals {
  wait_until = {
    runcmd = [{
      template = "${path.module}/templates/wait_until/${local.yml_runcmd}.tpl",
      vars     = {}
    }]
  }
}
