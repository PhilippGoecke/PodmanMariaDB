#!/bin/bash

DBNAME="your_database"
ROOT_PASSWORD="your_password"

#podman run -it --rm docker.io/library/mariadb:latest mariadb -h localhost -p 3306 -uroot -p"$ROOT_PASSWORD" -e "USE $DBNAME; DROP TABLE tablename;"
#podman run -it --rm docker.io/library/mariadb:latest mariadb -h localhost -p 3306 -uroot -p"$ROOT_PASSWORD" -e "DROP DATABASE $DBNAME;"
