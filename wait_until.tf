locals {
  wait_until = {
    runcmd = !local.parts_active.wait_until ? [] : concat(
      [
        {
          template = "${path.module}/templates/wait_until/${local.yml_runcmd}_install.tpl",
          vars     = {}
        }
      ],
      [for wait_until_script in var.wait_until_scripts :
        {
          template = "${path.module}/templates/wait_until/${local.yml_runcmd}_write_file_script.tpl",
          vars = {
            write_file_directory = "/root",
            write_file_name      = wait_until_script.file_name,
            write_file_content   = wait_until_script.content,
            write_file_owner     = "root"
            write_file_group     = "root"
            write_file_mode      = "755",
          }
        }
      ],
    )
  }
}
