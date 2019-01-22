FROM drupal:7
RUN apt update -y
RUN apt install -qq -y sudo wget git unzip
RUN apt update -y && apt upgrade -y && apt dist-upgrade -y
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod lbmethod_byrequests && service apache2 restart
RUN echo "export PATH=~/.local/bin:$PATH" >> ~/.bashrc
RUN echo 'entermedia ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ADD ./bash/.bashrc /root/.bashrc
ADD ./scripts/drupal-sshd.sh /usr/bin/drupal-sshd.sh
ADD ./scripts/drupal-deploy.sh /usr/bin/drupal-deploy.sh
