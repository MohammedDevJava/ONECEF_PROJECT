#!/bin/bash
set -e

# Get database connection details from environment
DB_HOST=${HOST}
DB_USER=${USER}  
DB_PASSWORD=${PASSWORD}
HTTP_PORT=${PORT:-8069}

echo "Connecting to database:"
echo "Host: $DB_HOST"
echo "User: $DB_USER"
echo "Port: $HTTP_PORT"

# Wait for database to be available
echo "Waiting for database connection..."
until pg_isready -h "$DB_HOST" -p 5432 -U "$DB_USER"; do
  echo "Database not ready, waiting..."
  sleep 2
done

echo "Database is ready, starting Odoo..."

# Start Odoo with explicit TCP connection
exec odoo \
    --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
    --db_host="$DB_HOST" \
    --db_port=5432 \
    --db_user="$DB_USER" \
    --db_password="$DB_PASSWORD" \
    --http-port="$HTTP_PORT" \
    --workers=0 \
    --max-cron-threads=1 \
    --without-demo=all \
    --log-level=info