#!/bin/bash
set -e

# Garante que o diretório de runtime e logs existam com permissões corretas
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chmod 777 /var/run/mysqld

mkdir -p /var/log/mysql
chown -R mysql:mysql /var/log/mysql

export MARIADB_ROOT_PASSWORD="$(cat /run/secrets/mariadb_root_password)"
export MARIADB_PASSWORD="$(cat /run/secrets/mariadb_password)"

# Check if MariaDB is already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# Always create init file to ensure users and permissions are correct
# This fixes the issue where persistent volume has data but missing users/grants
cat << EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
chown mysql:mysql /etc/mysql/init.sql

echo "Starting MariaDB..."
exec mysqld_safe --datadir=/var/lib/mysql --bind-address=0.0.0.0 --init-file=/etc/mysql/init.sql