#!/bin/bash
set -e

echo "🚀 Starting Odoo with your database configuration..."
echo "Database: $DB_HOST"
echo "Database Name: $DB_NAME"
echo "User: $DB_USER"

# Wait for database (simple approach)
echo "⏳ Waiting for database to be ready..."
sleep 10

# Start Odoo
echo "▶️ Starting Odoo server..."
exec odoo \
    --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
    --db_host="$DB_HOST" \
    --db_port="$DB_PORT" \
    --db_user="$DB_USER" \
    --db_password="$DB_PASSWORD" \
    --http-port="$PORT" \
    --workers=0 \
    --without-demo=all \
    --db-filter="$DB_NAME"