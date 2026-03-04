#!/bin/bash

DB_HOST=localhost
DB_PORT=3306
DBNAME="your_database"
ROOT_PASSWORD="your_password"

# podman run -it --rm docker.io/library/mariadb:latest mariadb -h $DB_HOST -P $DB_PORT -uroot -p"$ROOT_PASSWORD" -e "USE $DBNAME; DROP TABLE IF EXISTS tablename;"
# podman run -it --rm docker.io/library/mariadb:latest mariadb -h $DB_HOST -P $DB_PORT -uroot -p"$ROOT_PASSWORD" -e "DROP DATABASE IF EXISTS $DBNAME;"
