#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "database not initialized. try start..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld_safe &

while ! mysqladmin ping --silent; do
    sleep 1
done

mysql <<EOF
CREATE DATABASE IF NOT EXISTS ${WP_DB_NAME};
CREATE USER IF NOT EXISTS '${WP_DB_USER}'@'%' IDENTIFIED BY '${WP_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'%' IDENTIFIED BY '${WP_DB_PASSWORD}';
FLUSH PRIVILEGES;
EOF

if [ -d "/docker-entrypoint-initdb.d" ]; then
    for script in /docker-entrypoint-initdb.d/*.sql; do
        echo "install: $script"
        mysql < "$script"
    done
fi

wait $!
