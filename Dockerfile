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

# Expose the port
EXPOSE 8069

USER odoo

CMD ["odoo", "--config=/etc/odoo/odoo.conf"]
