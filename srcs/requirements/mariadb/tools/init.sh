#!/bin/sh

### owner setting ###
chown -R mysql:mysql /var/lib/mysql
#####################

### mariaDB setting ###
service mariadb start
sleep 1
#######################

### Permission setting ###
echo "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME ;" > init.sql
echo "CREATE USER IF NOT EXISTS '$DATABASE_USER'@'%' IDENTIFIED BY '$DATABASE_PASSWORD' ;" >> init.sql
echo "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%' ;" >> init.sql
echo "FLUSH PRIVILEGES;" >> init.sql

mysql < init.sql
sleep 1
##########################


### mariaDB stopping ###
service mariadb stop
sleep 1
########################


### Foreground start ###
mariadbd #포그라운드로 설정
########################