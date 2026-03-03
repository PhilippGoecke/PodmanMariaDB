#!/bin/bash

USERNAME="your_user"
DBNAME="your_database"
ROOT_PASSWORD="your_password"
USER_PASSWORD="your_user_password"

# Check if user exists
if ! podman exec mariadb mariadb -uroot -p"$ROOT_PASSWORD" -e "SELECT User FROM mysql.user WHERE User='$USERNAME'" | grep -q "$USERNAME"; then
    echo "Creating user..."
    podman exec mariadb mariadb -uroot -p"$ROOT_PASSWORD" -e "CREATE USER '$USERNAME'@'%' IDENTIFIED BY '$USER_PASSWORD';"
    podman exec mariadb mariadb -uroot -p"$ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$USERNAME'@'%'; FLUSH PRIVILEGES;"
else
    echo "User already exists"
fi

# Check if database exists
if ! podman exec mariadb mariadb -uroot -p"$ROOT_PASSWORD" -e "USE $DBNAME" &>/dev/null; then
    echo "Creating database..."
    podman exec mariadb mariadb -uroot -p"$ROOT_PASSWORD" -e "CREATE DATABASE $DBNAME;"
else
    echo "Database already exists"
fi

podman run -it --rm docker.io/library/mariadb:latest mariadb -h localhost -p 3306 -u"$USERNAME" -p"$USER_PASSWORD" -e "SHOW FULL TABLES FROM $DBNAME;"
