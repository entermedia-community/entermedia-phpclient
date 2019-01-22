#!/bin/bash

/usr/bin/drupal-sshd.sh
/usr/sbin/apache2ctl -D FOREGROUND
