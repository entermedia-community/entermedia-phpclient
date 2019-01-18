#!/bin/bash

#
# Launch EnterMediadb 9.x instance
#

if [ -z $BASH ]; then
  echo Using Bash...
  exec "/bin/bash" $0 $@
  exit
fi

# Root check
if [[ ! $(id -u) -eq 0 ]]; then
  echo You must run this script as the superuser.
  exit 1
fi

if [ "$#" -ne 5 ]; then
    echo "usage: sitename nodenumber mysql_dbname mysql_user mysql_password"
    exit 1
fi

# Setup
SITE=$1
NODENUMBER=$2
MYSQL_DB_NAME=$3
MYSQL_USER=$4
MYSQL_PASSWORD=$5
DATE=`date '+%Y-%m-%d %H:%M:%S'`

if [ ${#NODENUMBER} -ge 4 ]; then echo "Node Number must be between 100-250" ; exit
else echo "Using Node Number: $NODENUMBER"
fi


INSTANCE=$SITE$NODENUMBER

# For dev
BRANCH=latest

# Pull latest images
docker pull mariadb:latest:$BRANCH

ALREADY=$(docker ps -aq --filter name=$INSTANCE)
[[ $ALREADY ]] && docker stop -t 60 $ALREADY && docker rm -f $ALREADY

IP_ADDR="172.80.0.$NODENUMBER"

ENDPOINT=/media/emsites/$SITE

# Create entermedia user if needed
if [[ ! $(id -u entermedia 2> /dev/null) ]]; then
  groupadd entermedia > /dev/null
  useradd -g entermedia entermedia > /dev/null
fi
USERID=$(id -u entermedia)
GROUPID=$(id -g entermedia)

# Docker networking
if [[ ! $(docker network ls | grep drupal-em) ]]; then
  docker network create --subnet 172.80.0.0/16 drupal-em
fi

# Initialize site root
mkdir -p ${ENDPOINT}/{$NODENUMBER,services}
chown entermedia. ${ENDPOINT}
chown entermedia. ${ENDPOINT}/{$NODENUMBER,services}

# Create custom scripts
SCRIPTROOT=${ENDPOINT}/$NODENUMBER

echo "sudo docker start $INSTANCE" > ${SCRIPTROOT}/start.sh
echo "sudo docker stop -t 60 $INSTANCE" > ${SCRIPTROOT}/stop.sh
echo "sudo docker logs -f --tail 500 $INSTANCE"  > ${SCRIPTROOT}/logs.sh
echo "sudo docker exec $INSTANCE sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_PASSWORD"' > $INSTANCE/services/all-databases.sql" > ${SCRIPTROOT}/drupal-dump-$DATE.sh
echo "sudo docker exec -it $INSTANCE bash"  > ${SCRIPTROOT}/bash.sh
echo "sudo bash $SCRIPTROOT/mariadb-docker.sh $SITE $NODENUMBER" > ${SCRIPTROOT}/rebuild.sh
#echo 'sudo docker exec -it -u 0 '$INSTANCE' entermediadb-update-em9.sh $1 $2' > ${SCRIPTROOT}/update-em9.sh

chmod +x $SCRIPTROOT/*
# Fix File Limits
if grep -Fxq "entermedia" /etc/security/limits.conf
then
	# code if found
	echo ""
else
	# code if not found
	echo "fs.file-max = 10000000" >> /etc/sysctl.conf
	echo "entermedia      soft    nofile  409600" >> /etc/security/limits.conf
	echo "entermedia      hard    nofile  1024000" >> /etc/security/limits.conf
	sysctl -p
fi

# Fix permissions
chown -R entermedia. "${ENDPOINT}/$NODENUMBER"
rm -rf "/tmp/$NODENUMBER"  2>/dev/null
mkdir -p "/tmp/$NODENUMBER"
chown entermedia. "/tmp/$NODENUMBER"

echo "Review the following URL to get the full TZ list"
echo "https://en.wikipedia.org/wiki/List_of_tz_database_time_zones"
echo "Default time zone(TZ) will be US Eastern time"

set -e
docker run -t \
  --restart unless-stopped \
  --ip $IP_ADDR \
  --name $INSTANCE \
  --net drupal-em \
  --log-opt max-size=100m --log-opt max-file=2 \
	--cap-add=SYS_PTRACE \
	-e TZ="America/New_York" \
	-e USERID=$USERID \
	-e GROUPID=$GROUPID \
	-e CLIENT_NAME=$SITE \
	-e INSTANCE_PORT=$NODENUMBER \
  -e MYSQL_USER=$MYSQL_USER \
  -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
  -e MYSQL_DATABASE=$MYSQL_DATABASE \
  -d mariadb

echo ""
echo "Node is running in $SCRIPTROOT"
echo ""
