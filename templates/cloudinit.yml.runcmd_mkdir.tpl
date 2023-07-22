%{for directory in jsondecode(jsonencoded_directories) ~}
  - mkdir --parent ${directory}
%{ endfor }