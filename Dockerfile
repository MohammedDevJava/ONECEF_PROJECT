FROM odoo:18

# Fix locale issues
USER root
RUN apt-get update && apt-get install -y locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Copy your custom addons
COPY ./odoo_oncef /mnt/extra-addons

USER odoo

# Remove the invalid --db_name parameter
CMD ["sh", "-c", "odoo --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons --db_host=$DB_HOST --db_port=5432 --db_user=$DB_USER --db_password=$DB_PASSWORD --http-port=$PORT --workers=0 --max-cron-threads=1"]