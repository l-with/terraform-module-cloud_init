locals {
  s3cmd = !var.s3cmd ? {} : {
    runcmd = [{
      template = "${path.module}/templates/s3cmd/${local.yml_runcmd}.tpl",
      vars     = {}
    }]
  }
}
