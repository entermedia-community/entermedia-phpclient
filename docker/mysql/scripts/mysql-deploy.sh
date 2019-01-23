#!/bin/bash

if [[ ! `id -u` -eq 0 ]]; then
	echo You must run this script as a superuser.
	exit 1
fi

EM_USER=$1
PASSWORD=$2

if [ ! -d /media/services ]; then
	mkdir /media/services
fi


if [ ! -f /media/services/startup.sh ]; then
	wget -O /media/services/startup.sh https://raw.githubusercontent.com/entermedia-community/entermedia-phpclient/master/docker/mysql/scripts/startup.sh
	chmod +x /media/services/startup.sh
fi


sed -i -e 's/EMUSER/'$EM_USER'/g' /tmp/user.sql
sed -i -e 's/EMPASSWORD/'$PASSWORD'/g' /tmp/user.sql

#Run command
echo Starting MySQL ...

mysql -u root -psupersecret < /tmp/user.sql
# while true
# do
#   tail -f /var/log/apache2/access.log
# done
