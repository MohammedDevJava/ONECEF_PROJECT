#!/bin/bash
set -e

# Clear any conflicting environment variables
unset DATABASE_URL
unset PGHOST PGPORT PGUSER PGPASSWORD PGDATABASE

echo "🚀 Starting Odoo initialization..."

# Database connection details
DB_HOST="dpg-d17blgh5pdvs7386ecn0-a.oregon-postgres.render.com"
DB_PORT="5432"
DB_USER="odoo_db_hu7t_user"
DB_PASSWORD="5ji4IDqrKXRsVaWL4OYf121C3NCjBpWd"
DB_NAME="odoo_db_hu7t"

# Check if database is initialized
echo "🔍 Checking database status..."
if PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1 FROM information_schema.tables WHERE table_name = 'ir_module_module' LIMIT 1;" 2>/dev/null | grep -q '1'; then
    echo "✅ Database already initialized"
    INIT_DB=""
else
    echo "🆕 Database needs initialization"
    INIT_DB="--init=base"
fi

echo "🚀 Starting Odoo server on port 10000..."

# Start Odoo
exec odoo \
    --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
    --db_host="$DB_HOST" \
    --db_port="$DB_PORT" \
    --db_user="$DB_USER" \
    --db_password="$DB_PASSWORD" \
    --database="$DB_NAME" \
    --http-port=10000 \
    --workers=0 \
    --without-demo=all \
    --limit-time-cpu=600 \
    --limit-time-real=1200 \
    --limit-memory-hard=2684354560 \
    --limit-memory-soft=2147483648 \
    --max-cron-threads=1 \
    --log-level=info \
    --admin-passwd=admin123 \
    --list-db=False \
    $INIT_DB