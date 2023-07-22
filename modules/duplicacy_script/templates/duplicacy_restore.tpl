#!/bin/sh

# cd to working directory
cd ${duplicacy_working_directory}

# env
%{ for key, value in duplicacy_env }
export ${key}="${value}"
%{ endfor }

# env restore
%{ for key, value in duplicacy_env_restore }
export ${key}="${value}"
%{ endfor }

# env special
%{ for key, value in duplicacy_env_special }
export ${key}="${value}"
%{ endfor }

# initialize restore log
echo >${duplicacy_log_file}

# pre restore
status=0
if [ -f ${duplicacy_script_file_directory}/${duplicacy_pre_restore_script_file_name} ]; then
    echo $(date "+%Y-%m-%d %H:%M:%S.%3N") INFO SCRIPT_RUN Running script ${duplicacy_script_file_directory}/${duplicacy_pre_restore_script_file_name} |\
        tee --append ${duplicacy_log_file}
    bash ${duplicacy_script_file_directory}/${duplicacy_pre_restore_script_file_name}
    status=$?
fi

if [ $status != 0 ]; then
    echo $(date "+%Y-%m-%d %H:%M:%S.%3N") ERROR SCRIPT_RUN Status code "'"$status"'" from script ${duplicacy_script_file_directory}/${duplicacy_pre_restore_script_file_name} |\
        tee --append ${duplicacy_log_file}
else
# restore
    export _duplicacy_backup_revision=$$(${duplicacy_path}/bin/duplicacy list | tail -n 1 | cut -d " " -f 4)
    if [ -z "$${_duplicacy_backup_revision##*[!0-9]*}" ]; then
        echo $(date "+%Y-%m-%d %H:%M:%S.%3N") ERROR REVISION_SET not a number "'"$$_duplicacy_backup_revision"'" |\
            tee --append ${duplicacy_log_file}
    else
        echo $(date "+%Y-%m-%d %H:%M:%S.%3N") INFO REVISION_SET Last revision $$_duplicacy_backup_revision |\
            tee --append ${duplicacy_log_file}
        ${duplicacy_path}/bin/duplicacy -log restore ${duplicacy_restore_options} -r $$_duplicacy_backup_revision |\
            tee --append ${duplicacy_log_file}
    fi
fi

# post restore
if [ -f ${duplicacy_script_file_directory}/${duplicacy_post_restore_script_file_name} ]; then
    bash ${duplicacy_script_file_directory}/${duplicacy_post_restore_script_file_name}
    status=$?
    exit $status
fi
