FROM mariadb:latest
RUN apt update -y && apt upgrade -y && apt dist-upgrade -y
RUN apt install -y vim
ADD ./dist/user.sql /var/lib/mysql/user.sql
ADD ./scripts/mysql-deploy.sh /usr/bin/mysql-deploy.sh
CMD /bin/bash
