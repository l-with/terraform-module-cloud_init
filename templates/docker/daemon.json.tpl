{
%{if !docker_manipulate_iptables ~}  
  "iptables": "false"
%{endif ~}
%{if docker_registry_mirror != null ~}
  "registry-mirrors": ["${docker_registry_mirror}"]
%{endif ~}
%{if docker_insecure_registry != null ~}
  "insecure_registries": ["${docker_insecure_registry}"]
%{endif ~}
}