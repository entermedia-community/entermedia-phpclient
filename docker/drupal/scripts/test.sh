#!/bin/bash

echo "sudo docker exec $INSTANCE sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_PASSWORD"' > $INSTANCE/services/all-databases.sql" > drupal-dump.sh
