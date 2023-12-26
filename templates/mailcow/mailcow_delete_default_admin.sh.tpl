#!/usr/bin/env bash
# set DBUSER, DBPASS, DBNAME
set -a && source $${_MAILCOW_INSTALL_PATH}/mailcow.conf && set +a

# delete admin
echo delete admin
docker exec $(docker ps --quiet --filter name=mysql-mailcow) mysql -u$${DBUSER} -p$${DBPASS} $${DBNAME} -e "DELETE FROM admin WHERE username='$${_MAILCOW_DEFAULT_ADMIN}';"

# delete TFA
echo delete TFA
docker exec $(docker ps --quiet --filter name=mysql-mailcow) mysql -u$${DBUSER} -p$${DBPASS} $${DBNAME} -e "DELETE FROM tfa WHERE username='$${_MAILCOW_DEFAULT_ADMIN}';"
