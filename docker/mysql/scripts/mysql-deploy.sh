#!/bin/bash

if [[ ! `id -u` -eq 0 ]]; then
	echo You must run this script as a superuser.
	exit 1
fi

EM_USER=$1
PASSWORD=$2

sed -i -e 's/EMUSER/'$EM_USER'/g' /var/lib/mysql/user.sql
sed -i -e 's/EMPASSWORD/'$PASSWORD'/g' /var/lib/mysql/user.sql

#Run command
echo Starting MySQL ...
bash /sbin/my_init

mysql -u root -psupersecret < /var/lib/mysql/user.sql
# while true
# do
#   tail -f /var/log/apache2/access.log
# done
