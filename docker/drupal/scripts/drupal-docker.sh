#!/bin/bash -x

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

if [ "$#" -ne 2 ]; then
    echo "usage: sitename nodenumber"
    exit 1
fi

# Setup
SITE=$1
NODENUMBER=$2

if [ ${#NODENUMBER} -ge 4 ]; then echo "Node Number must be between 100-250" ; exit
else echo "Using Node Number: $NODENUMBER"
fi


INSTANCE=$SITE$NODENUMBER

# For dev
BRANCH=latest

# Pull latest images
docker pull entermediadb/entermedia-phpclient:$BRANCH

ALREADY=$(docker ps -aq --filter name=$INSTANCE)
[[ $ALREADY ]] && docker stop -t 60 $ALREADY && docker rm -f $ALREADY

IP_ADDR="172.80.0.$NODENUMBER"

ENDPOINT=/media/drupal/$SITE

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

# TODO: support upgrading, start, stop and removing

# Initialize site root
mkdir -p ${ENDPOINT}/{$NODENUMBER,services}
chown entermedia. ${ENDPOINT}
chown entermedia. ${ENDPOINT}/{$NODENUMBER,services}

# Create custom scripts
SCRIPTROOT=${ENDPOINT}/$NODENUMBER

echo "sudo docker start $INSTANCE" > ${SCRIPTROOT}/start.sh
echo "sudo docker stop -t 60 $INSTANCE" > ${SCRIPTROOT}/stop.sh
echo "sudo docker logs -f --tail 500 $INSTANCE"  > ${SCRIPTROOT}/logs.sh
echo "sudo docker exec -it --user $USERID --workdir /media/services/git/entermedia-phpclient/client $INSTANCE bash"  > ${SCRIPTROOT}/bash.sh
echo "sudo bash $SCRIPTROOT/drupal-docker.sh $SITE $NODENUMBER" > ${SCRIPTROOT}/rebuild.sh
#echo 'sudo docker exec -it -u 0 '$INSTANCE' entermediadb-update-em9.sh $1 $2' > ${SCRIPTROOT}/update-em9.sh

cp  $0  ${SCRIPTROOT}/drupal-docker.sh 2>/dev/null
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
# Run Create Docker Instance, add Mounted HotFolders as needed
docker run -t -d \
	--restart unless-stopped \
	--net drupal-em \
	`#-p 22$NODENUMBER:22` \
	--ip $IP_ADDR \
  -p 8080:80 \
	--name $INSTANCE \
	--log-opt max-size=100m --log-opt max-file=2 \
	--cap-add=SYS_PTRACE \
	-e TZ="America/New_York" \
	-e USERID=$USERID \
	-e GROUPID=$GROUPID \
	-e CLIENT_NAME=$SITE \
	-e INSTANCE_PORT=$NODENUMBER \
	-v ${ENDPOINT}/services:/media/services \
	-v ${ENDPOINT}/$NODENUMBER/tmp:/tmp \
	entermediadb/entermedia-phpclient:$BRANCH \
  /usr/bin/drupal-deploy.sh

echo ""
echo "Node is running: curl http://$IP_ADDR:8080 in $SCRIPTROOT"
echo ""
