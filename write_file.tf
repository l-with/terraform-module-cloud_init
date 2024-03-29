locals {
  write_file = {
    runcmd = !local.parts_active.write_file ? [] : [
      for index, file in var.write_files :
      {
        template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
        vars = {
          write_file_directory = dirname(file.file_name),
          write_file_name      = basename(file.file_name),
          write_file_content   = file.encoding == "base64" ? base64decode(file.content) : file.content,
          write_file_owner     = file.owner,
          write_file_group     = file.group,
          write_file_mode      = file.mode,
        }
      }
    ],
  }
}
