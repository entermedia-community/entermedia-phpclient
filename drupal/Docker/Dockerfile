FROM centos:latest
RUN yum install -y sudo yum-utils wget git unzip php-mbstring php-gd php-xml
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php71
RUN yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
RUN yum update -y
RUN echo "export PATH=~/.local/bin:$PATH" >> ~/.bashrc
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN wget http://ftp.drupal.org/files/projects/drupal-7.59.zip
RUN unzip -q drupal-7.59.zip -d /var/www/html/
RUN mv /var/www/html/drupal-7.59/ /var/www/html/drupal
RUN chown -R apache:apache /var/www/html/drupal
RUN cp -p /var/www/html/drupal/sites/default/default.settings.php /var/www/html/drupal/sites/default/settings.php
CMD /bin/bash
