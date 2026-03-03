#!/bin/bash

# Starte MariaDB Container
podman run --detach \
    --name mariadb \
    --env MARIADB_ROOT_PASSWORD=your_password \
    --env MARIADB_USER=example-user \
    --env MARIADB_PASSWORD=my_cool_secret \
    --env MARIADB_DATABASE=exmple-database \
    --publish 3306:3306 \
    -v mariadb_data:/var/lib/mysql \
    docker.io/library/mariadb:latest
