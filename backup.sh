
#!/bin/bash
set -euo pipefail

BACKUP_DIR="./backups"
DB_NAME="appdb"
DB_USER="postgres"
DB_HOST="127.0.0.1"
DB_PORT="5433"

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.dump"

export PGPASSWORD="practice"

echo "Starting database backup..."

pg_dump -h "$DB_HOST" -p "$DB_PORT" \
  -U "$DB_USER" -d "$DB_NAME" \
  -Fc -f "$BACKUP_FILE"

echo "Checking backup integrity..."

pg_restore --list "$BACKUP_FILE" > /dev/null

echo "Backup successful: $BACKUP_FILE"
