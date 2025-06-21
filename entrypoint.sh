#!/bin/bash
set -e

# Set defaults if environment variables are empty
DB_HOST=${DB_HOST:-dpg-d17blgh5pdvs7386ecn0-a.oregon-postgres.render.com}
DB_PORT=${DB_PORT:-5432}
DB_USER=${DB_USER:-odoo_db_hu7t_user}
DB_PASSWORD=${DB_PASSWORD:-5ji4IDqrKXRsVaWL4OYf121C3NCjBpWd}
DB_NAME=${DB_NAME:-odoo_db_hu7t}
PORT=${PORT:-10000}

echo "🚀 Starting Odoo with your database configuration..."
echo "Database: $DB_HOST"
echo "Database Name: $DB_NAME"
echo "User: $DB_USER"
echo "Port: $DB_PORT"
echo "HTTP Port: $PORT"

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