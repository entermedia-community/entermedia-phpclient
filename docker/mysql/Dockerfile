FROM mariadb:latest
RUN apt update -y && apt upgrade -y && apt dist-upgrade -y
RUN apt install -y vim
COPY ./dist/user.sql /var/lib/mysql/user.sql
CMD /bin/bash
