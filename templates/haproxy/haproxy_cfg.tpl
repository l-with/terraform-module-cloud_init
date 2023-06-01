%{ if haproxy_configuration.global != null }global
${haproxy_configuration.global.configuration}%{ endif }%{ for frontend in haproxy_configuration.frontend }
frontend ${frontend.label}
${frontend.configuration}%{ endfor }%{ for backend in haproxy_configuration.backend }
backend ${backend.label}
${backend.configuration}%{ endfor }%{ for defaults in haproxy_configuration.defaults }
defaults
${defaults.configuration}%{ endfor }%{ for listen in haproxy_configuration.listen }
listen ${listen.label}
${listen.configuration}%{ endfor }%{ for aggregations in haproxy_configuration.aggregations }
aggregations ${aggregations.label}
${aggregations.configuration}%{ endfor }%{ for cache in haproxy_configuration.cache }
cache
${cache}%{ endfor }%{ for dynamic-update in haproxy_configuration.dynamic-update }
dynamic-update
${dynamic-update}%{ endfor }%{ for fcgi-app in haproxy_configuration.fcgi-app }
fcgi-app ${fcgi-app.label}
${fcgi-app.configuration}%{ endfor }%{ for http-errors in haproxy_configuration.http-errors }
http-errors ${http-errors.label}
${http-errors.configuration}%{ endfor }%{ for mailers in haproxy_configuration.mailers }
mailers ${mailers.label}
${mailers.configuration}%{ endfor }%{ for peers in haproxy_configuration.peers }
peers ${peers.label}
${peers.configuration}%{ endfor }%{ for program in haproxy_configuration.program }
program ${program.label}
${program.configuration}%{ endfor }%{ for resolvers in haproxy_configuration.resolvers }
resolvers ${resolvers.label}
${resolvers.configuration}%{ endfor }%{ for ring in haproxy_configuration.ring }
ring ${ring.label}
${ring.configuration}%{ endfor }%{ for userlist in haproxy_configuration.userlist }
userlist ${userlist.label}
${userlist.configuration}%{ endfor }