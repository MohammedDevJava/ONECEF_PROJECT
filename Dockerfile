FROM odoo:18

# Fix locale
USER root
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8

# Copy addons
COPY ./odoo_oncef /mnt/extra-addons
RUN chown -R odoo:odoo /mnt/extra-addons

USER odoo

# Create Odoo configuration file
RUN mkdir -p /etc/odoo
RUN echo '[options]' > /etc/odoo/odoo.conf && \
    echo 'addons_path = /mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons' >> /etc/odoo/odoo.conf && \
    echo 'http_port = 8069' >> /etc/odoo/odoo.conf && \
    echo 'db_sslmode = prefer' >> /etc/odoo/odoo.conf

# Expose the port
EXPOSE 8069

# Command to run Odoo with initialization if needed
CMD if [ "$INIT_DB" = "true" ]; then \
        odoo -i base --stop-after-init \
        --db_host=$DB_HOST \
        --db_port=$DB_PORT \
        --db_user=$DB_USER \
        --db_password=$DB_PASSWORD \
        --database=$DB_NAME \
        && exec odoo \
        --db_host=$DB_HOST \
        --db_port=$DB_PORT \
        --db_user=$DB_USER \
        --db_password=$DB_PASSWORD \
        --database=$DB_NAME; \
    else \
        exec odoo \
        --db_host=$DB_HOST \
        --db_port=$DB_PORT \
        --db_user=$DB_USER \
        --db_password=$DB_PASSWORD \
        --database=$DB_NAME; \
    fi