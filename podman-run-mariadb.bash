#!/bin/bash

# Check if MariaDB container is already running
if ! podman ps | grep -q mariadb; then
    echo "Starting MariaDB container..."
    # Starte MariaDB Container
    podman run --detach \
        --name mariadb \
        --env MARIADB_ROOT_PASSWORD=your_password \
        --env MARIADB_USER=example-user \
        --env MARIADB_PASSWORD=my_cool_secret \
        --env MARIADB_DATABASE=exmple-database \
        --publish 3306:3306 \
        --volume mariadb_data:/var/lib/mysql \
        docker.io/library/mariadb:latest
    echo "MariaDB container started successfully"
elif podman ps | grep -q mariadb; then
    echo "Starting existing MariaDB container..."
    podman start mariadb
    echo "MariaDB container started successfully"
else
    echo "MariaDB container is already running"
fi

# Check if MariaDB is ready to accept connections
echo "Waiting for MariaDB to be ready..."
until podman exec mariadb mariadb -uroot -pyour_password -e "SELECT 1" &>/dev/null; do
  # podman run -it --rm docker.io/library/mariadb:latest mariadb -h<remote_host> -p3306 -uroot -pyour_password -e "SELECT 1"
  echo "MariaDB is unavailable, retrying..."
  sleep 2
done
echo "MariaDB is ready"
