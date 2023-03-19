locals {
  docker_container = {
    write_files = concat(
      [
        for container in var.docker_container_list :
        {
          template = "${path.module}/templates/docker_container/${local.yml_write_files}_service.tpl",
          vars = {
            name           = container.name,
            description    = "docker ${container.name} (${container.image})"
            image          = container.image,
            ports          = container.ports
            command        = container.command
            restart_policy = container.restart_policy
          }
        }
      ]
    )
    runcmd = concat(
      [{
        template = "${path.module}/templates/docker_container/${local.yml_runcmd}.tpl",
        vars     = {}
      }],
      [
        for container in var.docker_container_list :
        {
          template = "${path.module}/templates/docker_container/${local.yml_runcmd}_service.tpl",
          vars = {
            name = container.name,
          }
        }
      ],
    )
  }
}
