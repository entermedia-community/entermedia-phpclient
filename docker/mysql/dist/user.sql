CREATE USER '$USER';
GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION;
SET PASSWORD FOR '$USER' = PASSWORD('$PASSWORD');