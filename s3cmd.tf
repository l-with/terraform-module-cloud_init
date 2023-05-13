locals {
  s3cmd = !local.parts_active.s3cmd ? {} : {
    runcmd = [{
      template = "${path.module}/templates/s3cmd/${local.yml_runcmd}.tpl",
      vars     = {}
    }]
  }
}
