FROM mariadb:latest
RUN apt update -y && apt upgrade -y && apt dist-upgrade -y
RUN apt install -y vim
ADD ./scripts/mysql-deploy.sh /usr/bin/mysql-deploy.sh
CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/ */tmp/* /var/tmp/*
ADD ./dist/user.sql.template /tmp/user.sql
CMD /bin/bash
