#!/bin/bash -x

if [[ ! `id -u` -eq 0 ]]; then
	echo You must run this script as a superuser.
	exit 1
fi
if [[ ! `id -u entermedia 2> /dev/null` ]]; then
	groupadd -g $GROUPID entermedia
	useradd -ms /bin/bash entermedia -g entermedia -u $USERID
fi

if [ ! -f /media/services/startup.sh ]; then
	wget -O /media/services/startup.sh https://raw.githubusercontent.com/entermedia-community/entermedia-phpclient/master/scripts/startup.sh
	chmod +x /media/services/startup.sh
fi

# Execute arbitrary scripts if provided
if [[ -d /media/services ]]; then
  chown entermedia. /media/services
  for script in $(ls /media/services/*.sh); do
    bash $script;
  done
fi

#Run command
echo Starting Drupal ...

pid=0

# SIGTERM-handler
term_handler() {
  pid=`pgrep -f "$CATALINA_BASE/conf/logging.properties"`
if [[ ! -z $pid ]]; then
  if [ $pid -ne 0 ]; then
	echo "Deployment shutdown start"
    kill -SIGTERM "$pid"
	while [ -e /proc/$pid ]
	do
		printf .
		sleep 1
	done
  fi
fi
  exit 143; # 128 + 15 -- SIGTERM
}

#SIGKILL

# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill ${!}; term_handler' SIGTERM
