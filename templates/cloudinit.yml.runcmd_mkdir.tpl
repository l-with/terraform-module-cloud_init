%{for directory in jsondecode(directories) ~}
  - mkdir --parent ${directory}
%{ endfor }