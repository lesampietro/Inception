#!/bin/bash
set -e

# Read passwords from secret files
if [ -f "$MARIADB_ROOT_PASSWORD_FILE" ]; then
    MARIADB_ROOT_PASSWORD=$(cat "$MARIADB_ROOT_PASSWORD_FILE")
    export MARIADB_ROOT_PASSWORD
fi

if [ -f "$MARIADB_PASSWORD_FILE" ]; then
    MARIADB_PASSWORD=$(cat "$MARIADB_PASSWORD_FILE")
    export MARIADB_PASSWORD
fi

# Check if MariaDB data directory is initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;

CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';

FLUSH PRIVILEGES;
EOF

    echo "MariaDB initialization complete."
else
    echo "MariaDB already initialized, skipping setup."
fi

# Allow connections from any host
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

echo "Starting MariaDB..."
exec "$@"