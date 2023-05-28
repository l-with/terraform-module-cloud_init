- path: /etc/haproxy/haproxy.cfg
  content: |
    %{ if jsondecode(haproxy_configuration).global != null }global
${jsondecode(haproxy_configuration).global}%{ endif }%{ for frontend in jsondecode(haproxy_configuration).frontend }
    frontend
${frontend}%{ endfor }%{ for backend in jsondecode(haproxy_configuration).backend }
    backend
${backend}%{ endfor }%{ for defaults in jsondecode(haproxy_configuration).defaults }
    defaults
${defaults}%{ endfor }%{ for listen in jsondecode(haproxy_configuration).listen }
    listen
${listen}%{ endfor }%{ for aggregations in jsondecode(haproxy_configuration).aggregations }
    aggregations
${aggregations}%{ endfor }%{ for cache in jsondecode(haproxy_configuration).cache }
    cache
${cache}%{ endfor }%{ for dynamic-update in jsondecode(haproxy_configuration).dynamic-update }
    dynamic-update
${dynamic-update}%{ endfor }%{ for fcgi-app in jsondecode(haproxy_configuration).fcgi-app }
    fcgi-app
${fcgi-app}%{ endfor }%{ for http-errors in jsondecode(haproxy_configuration).http-errors }
    http-errors
${http-errors}%{ endfor }%{ for mailers in jsondecode(haproxy_configuration).mailers }
    mailers
${mailers}%{ endfor }%{ for peers in jsondecode(haproxy_configuration).peers }
    peers
${peers}%{ endfor }%{ for program in jsondecode(haproxy_configuration).program }
    program
${program}%{ endfor }%{ for resolvers in jsondecode(haproxy_configuration).resolvers }
    resolvers
${resolvers}%{ endfor }%{ for ring in jsondecode(haproxy_configuration).ring }
    ring
${ring}%{ endfor }%{ for userlist in jsondecode(haproxy_configuration).userlist }
    userlist
${userlist}%{ endfor }
  permissions: '0644'
