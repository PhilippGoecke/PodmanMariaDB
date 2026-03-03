#!/bin/bash

# MariaDB backup script
BACKUP_DIR="$(pwd)/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

mkdir -p "$BACKUP_DIR"

podman exec mariadb mysqldump -uroot -pyour_password --all-databases > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "Backup completed: $BACKUP_FILE"
else
    echo "Backup failed"
    exit 1
fi

# Pull the latest MariaDB image
echo "Pulling latest MariaDB image..."
podman pull docker.io/library/mariadb:latest

# Stop and remove the old container
echo "Stopping MariaDB container..."
podman stop mariadb
podman rm mariadb

bash ./podman-run-mariadb.bash

# Restore from backup
#podman exec mariadb mysql -uroot -pyour_password < "$BACKUP_FILE"
#podman exec mariadb mysql -uroot -pyour_password your_database < /path/to/backup.sql
