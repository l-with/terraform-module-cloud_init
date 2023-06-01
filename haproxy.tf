locals {
  haproxy = !local.parts_active.haproxy ? {} : merge(
    {
      packages = [{
        template = "${path.module}/templates/haproxy/${local.yml_packages}.tpl",
        vars     = {}
      }]
    },
    var.haproxy_configuration == null ? {} : {
      runcmd = concat(
        var.haproxy_configuration == null ? [] : [{
          template = "${path.module}/templates/haproxy/${local.yml_runcmd}_write_file.tpl"
          vars = {
            write_file_directory = "/etc/haproxy"
            write_file_name      = "haproxy.cfg"
            write_file_mode      = "644"
            write_file_content = templatefile("${path.module}/templates/haproxy/haproxy_cfg.tpl", {
              haproxy_configuration = var.haproxy_configuration
            })
            /*
            <<EOT
%{ if var.haproxy_configuration.global != null }global
${var.haproxy_configuration.global.configuration}%{ endif }%{ for frontend in var.haproxy_configuration.frontend }
frontend ${frontend.label}
${frontend.configuration}%{ endfor }%{ for backend in var.haproxy_configuration.backend }
backend ${backend.label}
${backend.configuration}%{ endfor }%{ for defaults in var.haproxy_configuration.defaults }
defaults
${defaults.configuration}%{ endfor }%{ for listen in var.haproxy_configuration.listen }
listen ${listen.label}
${listen.configuration}%{ endfor }%{ for aggregations in var.haproxy_configuration.aggregations }
aggregations ${aggregations.label}
${aggregations.configuration}%{ endfor }%{ for cache in var.haproxy_configuration.cache }
cache
${cache}%{ endfor }%{ for dynamic-update in var.haproxy_configuration.dynamic-update }
dynamic-update
${dynamic-update}%{ endfor }%{ for fcgi-app in var.haproxy_configuration.fcgi-app }
fcgi-app ${fcgi-app.label}
${fcgi-app.configuration}%{ endfor }%{ for http-errors in var.haproxy_configuration.http-errors }
http-errors ${http-errors.label}
${http-errors.configuration}%{ endfor }%{ for mailers in var.haproxy_configuration.mailers }
mailers ${mailers.label}
${mailers.configuration}%{ endfor }%{ for peers in var.haproxy_configuration.peers }
peers ${peers.label}
${peers.configuration}%{ endfor }%{ for program in var.haproxy_configuration.program }
program ${program.label}
${program.configuration}%{ endfor }%{ for resolvers in var.haproxy_configuration.resolvers }
resolvers ${resolvers.label}
${resolvers.configuration}%{ endfor }%{ for ring in var.haproxy_configuration.ring }
ring ${ring.label}
${ring.configuration}%{ endfor }%{ for userlist in var.haproxy_configuration.userlist }
userlist ${userlist.label}
${userlist.configuration}%{ endfor }
EOT
*/
          }
        }],
        [{
          template = "${path.module}/templates/haproxy/${local.yml_runcmd}_restart.tpl",
          vars     = {}
        }],
      )
    }
  )
}
