#!/bin/bash

DB_HOST=host.containers.internal
USERNAME="rails"
DBNAME="blog"
ROOT_PASSWORD="your_password"
USER_PASSWORD="secret"

# Check if user exists
if ! podman run -it --rm docker.io/library/mariadb:latest mariadb -h $DB_HOST -uroot -p"$ROOT_PASSWORD" -e "SELECT User FROM mysql.user WHERE User='$USERNAME'" | grep -q "$USERNAME"; then
    echo "Creating user ..."
    podman run -it --rm docker.io/library/mariadb:latest mariadb -h $DB_HOST -uroot -p"$ROOT_PASSWORD" -e "CREATE USER '$USERNAME'@'%' IDENTIFIED BY '$USER_PASSWORD';"
else
    echo "User already exists"
fi

# Check if database exists
if ! podman run -it --rm docker.io/library/mariadb:latest mariadb -h $DB_HOST -uroot -p"$ROOT_PASSWORD" -e "USE $DBNAME" &>/dev/null; then
    echo "Creating database ..."
    podman run -it --rm docker.io/library/mariadb:latest mariadb -h $DB_HOST -uroot -p"$ROOT_PASSWORD" -e "CREATE DATABASE $DBNAME;"
    echo "Granting privileges ..."
    podman run -it --rm docker.io/library/mariadb:latest mariadb -h $DB_HOST -uroot -p"$ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$USERNAME'@'%'; FLUSH PRIVILEGES;"
else
    echo "Database already exists"
fi

podman run -it --rm docker.io/library/mariadb:latest mariadb -v -h $DB_HOST -u"$USERNAME" -p"$USER_PASSWORD" -e "SHOW FULL TABLES FROM $DBNAME;"
