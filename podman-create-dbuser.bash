#!/bin/bash

# Check if user exists
if ! podman exec mariadb mysql -uroot -pyour_password -e "SELECT User FROM mysql.user WHERE User='your_user'" | grep -q your_user; then
    echo "Creating user..."
    podman exec mariadb mysql -uroot -pyour_password -e "CREATE USER 'your_user'@'%' IDENTIFIED BY 'your_user_password';"
    podman exec mariadb mysql -uroot -pyour_password -e "GRANT ALL PRIVILEGES ON your_database.* TO 'your_user'@'%'; FLUSH PRIVILEGES;"
else
    echo "User already exists"
fi

# Check if database exists
if ! podman exec mariadb mysql -uroot -pyour_password -e "USE your_database" &>/dev/null; then
    echo "Creating database..."
    podman exec mariadb mysql -uroot -pyour_password -e "CREATE DATABASE your_database;"
else
    echo "Database already exists"
fi
