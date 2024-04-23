#!/bin/bash

if [ ! -f "/var/www/html/wp-config.php" ]; then

    rm -rf *.*

    wp core download --allow-root
    
    mv wp-config-sample.php wp-config.php

    sed -i "s/localhost/${WP_DB_HOST}/g" wp-config.php
	sed -i "s/database_name_here/${WP_DB_NAME}/g" wp-config.php
    sed -i "s/username_here/${WP_DB_USER}/g" wp-config.php
	sed -i "s/password_here/${WP_DB_PASSWORD}/g" wp-config.php

    wp core install --allow-root \
        --path=/var/www/html/wordpress \
        --url=${DOMAIN_NAME} \
        --title=inception \
        --admin_user=${WP_ADMIN_LOGIN} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --skip-email

    #wp user create --allow-root --user_login=${WP_USER_LOGIN} --user_email=${WP_USER_EMAIL} --role=editor --user_pass=${WP_USER_PASSWORD}
    wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=editor


    # wp plugin uninstall akismet hello --allow-root
    # wp plugin update --all --allow-root

    chown -R www-data:www-data /var/www/html/wordpress

fi

exec "$@"
