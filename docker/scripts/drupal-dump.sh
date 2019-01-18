sudo docker exec  sh -c 'exec mysqldump --all-databases -uroot -p' > /services/all-databases.sql
