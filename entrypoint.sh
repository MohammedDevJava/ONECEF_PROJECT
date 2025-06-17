#!/bin/bash
set -e

# Wait for database to be ready
echo "Waiting for database to be ready..."
echo "Connecting to: $DB_HOST:$DB_PORT with user: $DB_USER"
until PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d postgres -c '\q' 2>/dev/null; do
  >&2 echo "Database is unavailable - sleeping"
  sleep 1
done

>&2 echo "Database is up - executing command"

# Check if database exists and has base modules
DB_EXISTS=$(PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'" 2>/dev/null || echo "0")

if [ "$DB_EXISTS" != "1" ]; then
    echo "Database doesn't exist, creating and initializing..."
    # Initialize database with base modules
    odoo \
        --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
        --db_host="$DB_HOST" \
        --db_port="$DB_PORT" \
        --db_user="$DB_USER" \
        --db_password="$DB_PASSWORD" \
        --database="$DB_NAME" \
        --init=base,web \
        --stop-after-init \
        --without-demo=all
else
    echo "Database exists, checking if properly initialized..."
    # Check if ir_http model exists
    MODEL_EXISTS=$(PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -tAc "SELECT COUNT(*) FROM information_schema.tables WHERE table_name='ir_model' AND table_schema='public'" 2>/dev/null || echo "0")
    
    if [ "$MODEL_EXISTS" = "0" ]; then
        echo "Database exists but not properly initialized, reinitializing..."
        odoo \
            --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
            --db_host="$DB_HOST" \
            --db_port="$DB_PORT" \
            --db_user="$DB_USER" \
            --db_password="$DB_PASSWORD" \
            --database="$DB_NAME" \
            --init=base,web \
            --stop-after-init \
            --without-demo=all
    else
        echo "Database is properly initialized"
    fi
fi

echo "Starting Odoo server..."
# Start Odoo server
exec odoo \
    --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
    --db_host="$DB_HOST" \
    --db_port="$DB_PORT" \
    --db_user="$DB_USER" \
    --db_password="$DB_PASSWORD" \
    --http-port="$PORT" \
    --workers=0 \
    --db-filter="$DB_NAME" \
    --without-demo=all