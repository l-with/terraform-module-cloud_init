locals {
  tool = {
    runcmd = !local.parts_active.tool ? [] : [
      for index, tool in var.tools :
      {
        template = "${path.module}/templates/tool/${local.yml_runcmd}_install.tpl",
        vars = {
          tool_name      = tool.name,
          tool_url       = tool.url,
          tool_dest_path = tool.dest_path,
        },
      }
    ],
  }
}
