#!/usr/bin/env bash

# get hashed password
hashed_mailcow_rspamd_ui_password=$(docker exec -it $(docker ps -qf name=rspamd-mailcow) rspamadm pw -p $${_MAILCOW_RSPAMD_UI_PASSWORD} | tr -d '\r')

# set password
echo 'password = "'$${hashed_mailcow_rspamd_ui_password}'";' >$${_MAILCOW_INSTALL_PATH}/data/conf/rspamd/override.d/worker-controller-password.inc
echo 'enable_password = "'$${hashed_mailcow_rspamd_ui_password}'";' >$${_MAILCOW_INSTALL_PATH}/data/conf/rspamd/override.d/worker-controller-password.inc
