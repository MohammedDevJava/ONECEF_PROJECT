FROM odoo:18

# Install PostgreSQL client
USER root
RUN apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy your custom addons
COPY ./odoo_oncef /mnt/extra-addons
RUN chown -R odoo:odoo /mnt/extra-addons

# Create a startup script
COPY --chown=odoo:odoo start.sh /start.sh
RUN chmod +x /start.sh

USER odoo

# Expose the port for Render
EXPOSE 10000

# Use the startup script
CMD ["odoo", "--config=/etc/odoo/odoo.conf", "-i", "base"]