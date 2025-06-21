#!/bin/bash
set -e

# Clear any conflicting environment variables
unset DATABASE_URL
unset PGHOST PGPORT PGUSER PGPASSWORD PGDATABASE

echo "🚀 Starting Odoo..."
echo "Port: 10000"

# Start Odoo with explicit configuration
exec odoo \
    --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
    --db_host=dpg-d17blgh5pdvs7386ecn0-a.oregon-postgres.render.com \
    --db_port=5432 \
    --db_user=odoo_db_hu7t_user \
    --db_password=5ji4IDqrKXRsVaWL4OYf121C3NCjBpWd \
    --http-port=10000 \
    --workers=0 \
    --without-demo=all \
    --limit-time-cpu=600 \
    --limit-time-real=1200 \
    --config=/etc/odoo/odoo.conf -i base