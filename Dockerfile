FROM odoo:18

# Copy your custom addons
COPY ./odoo_oncef /mnt/extra-addons

USER odoo

# Force TCP connection by explicitly setting database parameters
CMD ["sh", "-c", "odoo --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons --db_host=$HOST --db_port=5432 --db_user=$USER --db_password=$PASSWORD --http-port=$PORT --workers=0"]