locals {
  write_file = {
    runcmd = [
      for index, file in var.write_files :
      {
        template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
        vars = {
          write_file_directory = dirname(file.file_name),
          write_file_name      = basename(file.file_name),
          write_file_content   = file.content,
          write_file_mode      = file.mode,
        }
      }
    ],
  }
}
