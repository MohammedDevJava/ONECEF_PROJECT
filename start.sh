#!/bin/bash
set -e

# Clear any conflicting environment variables
unset DATABASE_URL
unset PGHOST PGPORT PGUSER PGPASSWORD PGDATABASE

echo "🚀 Starting Odoo..."
echo "Port: 10000"

# Create filestore directory for new database
mkdir -p /var/lib/odoo/filestore/odoo_18
chown -R odoo:odoo /var/lib/odoo/filestore

# Check if this is a fresh installation
if [ ! -f "/var/lib/odoo/.odoo_18_initialized" ]; then
    echo "🔧 First-time setup detected, initializing database odoo_18..."
    
    # Initialize with base modules
    odoo \
        --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
        --db_host=dpg-d17blgh5pdvs7386ecn0-a.oregon-postgres.render.com \
        --db_port=5432 \
        --db_user=odoo_db_hu7t_user \
        --db_password=5ji4IDqrKXRsVaWL4OYf121C3NCjBpWd \
        --database=odoo_18 \
        --init=base,web \
        --stop-after-init \
        --without-demo=all
    
    # Mark as initialized
    touch /var/lib/odoo/.odoo_18_initialized
    echo "✅ Database initialization complete"
else
    echo "📂 Using existing database"
fi

echo "▶️ Starting Odoo server..."

# Start Odoo with explicit configuration pointing to odoo_18
exec odoo \
    --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
    --db_host=dpg-d17blgh5pdvs7386ecn0-a.oregon-postgres.render.com \
    --db_port=5432 \
    --db_user=odoo_db_hu7t_user \
    --db_password=5ji4IDqrKXRsVaWL4OYf121C3NCjBpWd \
    --database=odoo_18 \
    --http-port=10000 \
    --workers=0 \
    --without-demo=all \
    --limit-time-cpu=600 \
    --limit-time-real=1200