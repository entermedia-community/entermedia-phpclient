#!/bin/bash -x

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
    echo "usage: mysql.sh mysqluser mysqlpassword"
    exit 1
fi


ENDPOINT=/media/drupal/mysql
NODENUMBER=2
IP_ADDR="172.80.0.$NODENUMBER"
BRANCH=latest
INSTANCE=mysql$NODENUMBER
MYSQLUSER=$1
MYSQLPASS=$2

# Pull latest images
docker pull entermediadb/entermedia-phpclient-mariadb:$BRANCH


#sudo groupadd -g 105 mysql
#sudo useradd -ms /bin/bash mysql -g mysql -u 103
#sudo mkdir -p $DIR_ROOT/mysql
#sudo chown -R mysql. $DIR_ROOT/mysql
#sudo docker stop unmysql
#sudo docker rm unmysql
##sudo docker run --net entermedia --name mysql --ip 172.18.0.2 -v $DIR_ROOT:/var/lib/mysql -d emmysql  /sbin/my_init


# Docker networking
if [[ ! $(docker network ls | grep drupal-em) ]]; then
  docker network create --subnet 172.80.0.0/16 drupal-em
fi

# Initialize site root
mkdir -p ${ENDPOINT}/services
chown entermedia. ${ENDPOINT}
chown entermedia. ${ENDPOINT}/services

# Create custom scripts
SCRIPTROOT=${ENDPOINT}
echo "sudo docker exec -it  $INSTANCE bash"  > ${SCRIPTROOT}/bash.sh


set -e
# Run Create Docker Instance, add Mounted HotFolders as needed
docker run -t -d \
        --restart unless-stopped \
        --net drupal-em \
        --ip $IP_ADDR \
        --name $INSTANCE \
        -v $ENDPOINT/lib/mysql:/var/lib/mysql \
        entermediadb/entermedia-phpclient-mariadb:$BRANCH \
        /usr/bin/mysql-deploy.sh $MYSQLUSER $MYSQLPASS


#echo mysql -u root -h 172.18.0.2 -P 3306 -p
#echo mysql --password=supersecret -u root
#echo "CREATE USER 'drupal';"

#echo "GRANT ALL PRIVILEGES ON *.* TO 'drupal'@'%' WITH GRANT OPTION;"
# Should we be granting privileges for 'drupal'@'%' or 172.17.0.1 or something?

#echo "SET PASSWORD FOR 'drupal' = PASSWORD('mypass');"

#echo sudo docker exec -it unmysql /bin/bash
#echo mysql -p -u mysql -h 172.18.0.2 -P 3306
#echo mysql -p -u root -h localhost -P 3306
