#!/usr/bin/env bash
# set DBUSER, DBPASS, DBNAME
source $${_MAILCOW_INSTALL_PATH}/mailcow.conf

# delete admin
docker exec --tty $(docker ps -qf name=mysql-mailcow) mysql -u$${DBUSER} -p$${DBPASS} $${DBNAME} -e "DELETE FROM admin WHERE username='$${_MAILCOW_DEFAULT_ADMIN}';"

# delete TFA
docker exec -tty $(docker ps -qf name=mysql-mailcow) mysql -u$${DBUSER} -p$${DBPASS} $${DBNAME} -e "DELETE FROM tfa WHERE username='$${_MAILCOW_DEFAULT_ADMIN}';"
