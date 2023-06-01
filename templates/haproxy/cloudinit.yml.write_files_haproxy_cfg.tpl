- path: ${haproxy_template_path}/haproxy.cfg
  content: |
    %{ if jsondecode(haproxy_configuration).global != null }global
${jsondecode(haproxy_configuration).global.configuration}%{ endif }%{ for frontend in jsondecode(haproxy_configuration).frontend }
    frontend ${frontend.label}
${frontend.configuration}%{ endfor }%{ for backend in jsondecode(haproxy_configuration).backend }
    backend ${backend.label}
${backend.configuration}%{ endfor }%{ for defaults in jsondecode(haproxy_configuration).defaults }
    defaults
${defaults.configuration}%{ endfor }%{ for listen in jsondecode(haproxy_configuration).listen }
    listen ${listen.label}
${listen.configuration}%{ endfor }%{ for aggregations in jsondecode(haproxy_configuration).aggregations }
    aggregations ${aggregations.label}
${aggregations.configuration}%{ endfor }%{ for cache in jsondecode(haproxy_configuration).cache }
    cache
${cache}%{ endfor }%{ for dynamic-update in jsondecode(haproxy_configuration).dynamic-update }
    dynamic-update
${dynamic-update}%{ endfor }%{ for fcgi-app in jsondecode(haproxy_configuration).fcgi-app }
    fcgi-app ${fcgi-app.label}
${fcgi-app.configuration}%{ endfor }%{ for http-errors in jsondecode(haproxy_configuration).http-errors }
    http-errors ${http-errors.label}
${http-errors.configuration}%{ endfor }%{ for mailers in jsondecode(haproxy_configuration).mailers }
    mailers ${mailers.label}
${mailers.configuration}%{ endfor }%{ for peers in jsondecode(haproxy_configuration).peers }
    peers ${peers.label}
${peers.configuration}%{ endfor }%{ for program in jsondecode(haproxy_configuration).program }
    program ${program.label}
${program.configuration}%{ endfor }%{ for resolvers in jsondecode(haproxy_configuration).resolvers }
    resolvers ${resolvers.label}
${resolvers.configuration}%{ endfor }%{ for ring in jsondecode(haproxy_configuration).ring }
    ring ${ring.label}
${ring.configuration}%{ endfor }%{ for userlist in jsondecode(haproxy_configuration).userlist }
    userlist ${userlist.label}
${userlist.configuration}%{ endfor }
  permissions: '0644'
