#!/bin/bash

DB_HOST=localhost
DB_PORT=3306
DB_USERNAME=your_username
DB_PASSWORD=your_password
DBNAME="your_database"
BACKUP_FILE="your_backup_file.sql"

podman run -it --rm docker.io/library/mariadb:latest mariadb -h $DB_HOST -P $DB_PORT -u$DB_USERNAME -p"$DB_PASSWORD" $DBNAME < "$BACKUP_FILE"
