FROM odoo:18

USER root

# Copy the custom addons
COPY ./odoo_oncef /mnt/extra-addons/

# Set permissions
RUN chown -R odoo:odoo /mnt/extra-addons/

# Create Odoo configuration file
RUN mkdir -p /etc/odoo
RUN echo '[options]' > /etc/odoo/odoo.conf
RUN echo 'addons_path = /mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons' >> /etc/odoo/odoo.conf
RUN echo 'http_port = 8069' >> /etc/odoo/odoo.conf
RUN echo 'longpolling_port = 8072' >> /etc/odoo/odoo.conf
RUN echo 'db_port = 5432' >> /etc/odoo/odoo.conf
RUN echo 'db_host = ${HOST}' >> /etc/odoo/odoo.conf
RUN echo 'db_user = ${POSTGRES_USER}' >> /etc/odoo/odoo.conf
RUN echo 'db_password = ${POSTGRES_PASSWORD}' >> /etc/odoo/odoo.conf
RUN echo 'db_name = ${POSTGRES_DB}' >> /etc/odoo/odoo.conf

# Expose the ports
EXPOSE 8069 8072

USER odoo

CMD ["odoo", "--config=/etc/odoo/odoo.conf"]
