module "test" {
  count = var.test ? 1 : 0

  source = "./modules/cloud_init_parts"

  part = "test"
  runcmd = [
    {
      template = "${path.module}/templates/test/${local.yml_runcmd}.tpl",
      vars = {
        test_var = "test value"
      }
    }
  ]
}
