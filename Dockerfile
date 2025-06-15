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

# Set permissions
RUN chown -R odoo:odoo /mnt/extra-addons

# Create Odoo configuration file
RUN mkdir -p /etc/odoo
RUN echo '[options]' > /etc/odoo/odoo.conf
RUN echo 'addons_path = /mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons' >> /etc/odoo/odoo.conf
RUN echo 'http_port = 8069' >> /etc/odoo/odoo.conf
RUN echo 'db_port = 5432' >> /etc/odoo/odoo.conf
RUN echo 'db_sslmode = prefer' >> /etc/odoo/odoo.conf

# Expose the ports
EXPOSE 8069

USER odoo

CMD ["odoo", \
     "--config=/etc/odoo/odoo.conf", \
     "--db_host=$DB_HOST", \
     "--db_port=5432", \
     "--db_user=$DB_USER", \
     "--db_password=$DB_PASSWORD", \
     "--database=$DB_NAME"]