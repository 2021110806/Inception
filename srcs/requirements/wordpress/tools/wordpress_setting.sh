#!/bin/sh

mkdir -p /var/www/html
cd /var/www/html
rm -rf *

wp core download --allow-root
wp config create --dbname="${DATABASE_NAME}" --dbuser="${DATABASE_USER}" --dbpass="${DATABASE_PASSWORD}" --dbhost="${DATABASE_HOST}" --allow-root
wp core install --url="${DOMAIN_NAME}" --title="${WORDPRESS_TITLE}" --admin_user="${WORDPRESS_ADMIN_NAME}" --admin_password="${WORDPRESS_ADMIN_PASSWORD}" --admin_email="${WORDPRESS_ADMIN_EMAIL}" --skip-email --allow-root
wp user create "${WORDPRESS_USER_NAME}" "${WORDPRESS_USER_EMAIL}" --user_pass="${WORDPRESS_USER_PASSWORD}" --role=author --allow-root 
wp theme install astra --activate --allow-root
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

exec /usr/sbin/php-fpm7.4 -F
