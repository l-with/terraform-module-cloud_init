  - export _MAILCOW_INSTALL_PATH="${mailcow_install_path}"
  - export _MAILCOW_DEFAULT_ADMIN="admin"
  - ${mailcow_delete_default_admin_script}
  - export _MAILCOW_ADMIN_USER="${mailcow_admin_user}"
  - export _MAILCOW_ADMIN_PASSWORD="${mailcow_admin_password}"
  - ${mailcow_set_admin_script}
  - export _MAILCOW_RSPAMD_UI_PASSWORD="${mailcow_rspamd_ui_password}"
  - ${mailcow_set_rspamd_ui_password_script}

