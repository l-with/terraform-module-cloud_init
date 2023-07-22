#!/bin/bash

# cd to working directory
cd ${duplicacy_working_directory}

# env
%{ for key, value in duplicacy_env }
export ${key}="${value}"
%{ endfor }

# env backup
%{ for key, value in duplicacy_env_backup }
export ${key}="${value}"
%{ endfor }

# env special
%{ for key, value in duplicacy_env_special }
export ${key}="${value}"
%{ endfor }

# initialize backup log
echo >${duplicacy_log_file}

# pre backup
status=0
if [ -f ${duplicacy_script_file_directory}/${duplicacy_pre_backup_script_file_name} ]; then
    echo $(date "+%Y-%m-%d %H:%M:%S.%3N") INFO SCRIPT_RUN Running script ${duplicacy_script_file_directory}/${duplicacy_pre_backup_script_file_name} |\
        tee --append ${duplicacy_log_file}
    bash ${duplicacy_script_file_directory}/${duplicacy_pre_backup_script_file_name}
    status=$?
fi

if [ $status != 0 ]; then
    echo $(date "+%Y-%m-%d %H:%M:%S.%3N") ERROR SCRIPT_RUN Status code "'"$status"'" from script ${duplicacy_script_file_directory}/${duplicacy_pre_backup_script_file_name} |\
        tee --append ${duplicacy_log_file}
else
# backup
    ${duplicacy_path}/bin/duplicacy -log backup ${duplicacy_backup_options} |\
        tee --append ${duplicacy_log_file}
fi

# post backup
if [ -f ${duplicacy_script_file_directory}/${duplicacy_post_backup_script_file_name} ]; then
    bash ${duplicacy_script_file_directory}/${duplicacy_post_backup_script_file_name}
    status=$?
    exit $status
fi
