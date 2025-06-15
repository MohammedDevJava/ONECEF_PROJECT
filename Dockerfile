FROM odoo:18

USER root

# Copy the custom addons
COPY ./odoo_oncef /mnt/extra-addons/

# Set permissions
RUN chown -R odoo:odoo /mnt/extra-addons/

# Expose the port
EXPOSE 8069

USER odoo
