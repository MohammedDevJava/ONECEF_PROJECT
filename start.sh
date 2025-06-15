#!/bin/bash
set -e

# Fix locale
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

echo "=== Starting Odoo with Database ==="
echo "Host: dpg-d17blgh5pdvs7386ecn0-a.oregon-postgres.render.com"
echo "Database: odoo_db_hu7t"
echo "User: odoo_db_hu7t_user"
echo "Port: $PORT"
echo "=================================="

# Start Odoo with your specific database details
exec odoo \
    --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons \
    --db_host="dpg-d17blgh5pdvs7386ecn0-a.oregon-postgres.render.com" \
    --db_port=5432 \
    --db_user="odoo_db_hu7t_user" \
    --db_password="5ji4IDqrKXRsVaWL4OYf121C3NCjBpWd" \
    --http-port="$PORT" \
    --workers=0 \
    --max-cron-threads=1 \
    --limit-time-cpu=600 \
    --limit-time-real=1200 \
    --log-level=info \
    --db-filter=.* \
    --without-demo=all