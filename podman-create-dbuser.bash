#!/bin/bash

USERNAME="your_user"
DBNAME="your_database"
ROOT_PASSWORD="your_password"
USER_PASSWORD="your_user_password"

# Check if user exists
if ! podman exec mariadb mysql -uroot -p"$ROOT_PASSWORD" -e "SELECT User FROM mysql.user WHERE User='$USERNAME'" | grep -q "$USERNAME"; then
    echo "Creating user..."
    podman exec mariadb mysql -uroot -p"$ROOT_PASSWORD" -e "CREATE USER '$USERNAME'@'%' IDENTIFIED BY '$USER_PASSWORD';"
    podman exec mariadb mysql -uroot -p"$ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$USERNAME'@'%'; FLUSH PRIVILEGES;"
else
    echo "User already exists"
fi

# Check if database exists
if ! podman exec mariadb mysql -uroot -p"$ROOT_PASSWORD" -e "USE $DBNAME" &>/dev/null; then
    echo "Creating database..."
    podman exec mariadb mysql -uroot -p"$ROOT_PASSWORD" -e "CREATE DATABASE $DBNAME;"
else
    echo "Database already exists"
fi
