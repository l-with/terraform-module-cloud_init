#!/bin/sh

# cd to working directory
cd ${duplicacy_working_directory}

# env
%{ for key, value in duplicacy_env }
export ${key}="${value}"
%{ endfor }

# env init
%{ for key, value in duplicacy_env_init }
export ${key}="${value}"
%{ endfor }

# env special
%{ for key, value in duplicacy_env_special }
export ${key}="${value}"
%{ endfor }

# init
${duplicacy_path}/bin/duplicacy init ${duplicacy_init_options} ${duplicacy_snapshot_id} "${duplicacy_storage_url}"
