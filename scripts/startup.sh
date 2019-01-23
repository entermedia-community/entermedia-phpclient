#!/bin/bash

/usr/bin/drupal-sshd.sh
/etc/init.d/mysql start
/usr/sbin/apache2ctl -D FOREGROUND
