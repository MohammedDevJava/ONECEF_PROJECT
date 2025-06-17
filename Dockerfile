FROM odoo:18

# Fix locale and install PostgreSQL client
USER root
RUN apt-get update && apt-get install -y locales postgresql-client && \
    locale-gen en_US.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8

# Copy addons
COPY ./odoo_oncef /mnt/extra-addons
RUN chown -R odoo:odoo /mnt/extra-addons

# Create entrypoint script
COPY --chown=odoo:odoo entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER odoo

# Use custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]