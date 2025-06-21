FROM odoo:18

# Install PostgreSQL client
USER root
RUN apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy your custom addons
COPY ./odoo_oncef /mnt/extra-addons
RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo

# Direct command with hardcoded database configuration
CMD ["odoo", \
     "--addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons", \
     "--db_host=dpg-d17blgh5pdvs7386ecn0-a.oregon-postgres.render.com", \
     "--db_port=5432", \
     "--db_user=odoo_db_hu7t_user", \
     "--db_password=5ji4IDqrKXRsVaWL4OYf121C3NCjBpWd", \
     "--http-port=10000", \
     "--workers=0", \
     "--without-demo=all", \
     "--db-filter=odoo_db_hu7t"]