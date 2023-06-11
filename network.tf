locals {
  network = {
    runcmd = concat(
      [
        for index, network_dispatcher_script in var.network_dispatcher_scripts :
        {
          template = "${path.module}/templates/network/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname("${var.network_dispatcher_script_path}/${network_dispatcher_script.script_file_name}"),
            write_file_name      = basename("${var.network_dispatcher_script_path}/${network_dispatcher_script.script_file_name}"),
            write_file_content   = network_dispatcher_script.script_file_content,
            write_file_owner     = "root",
            write_file_group     = "root",
            write_file_mode      = "755",
          }
        }
      ],
      [
        for index, network_dispatcher_script in var.network_dispatcher_scripts :
        {
          template = "${path.module}/templates/network/${local.yml_runcmd}_network_dispatcher_script.tpl",
          vars = {
            file_name = "/etc/network-dispatcher/${network_dispatcher_script.script_file_name}",
          }
        }
      ],
      [
        for index, network_resolved_conf in var.network_resolved_confs :
        {
          template = "${path.module}/templates/${local.yml_runcmd}_write_file.tpl",
          vars = {
            write_file_directory = dirname("${var.network_resolved_conf_path}/${network_resolved_conf.conf_file_name}"),
            write_file_name      = basename("${var.network_resolved_conf_path}/${network_resolved_conf.conf_file_name}"),
            write_file_content   = network_resolved_conf.conf_file_content,
            write_file_owner     = "root",
            write_file_group     = "root",
            write_file_mode      = "644",
          }
        }
      ],
      length(var.network_resolved_confs) == 0 ? [] :
      [{
        template = "${path.module}/templates/network/${local.yml_runcmd}_restart_resolved.tpl",
        vars     = {}
      }],
    )
  }
}
