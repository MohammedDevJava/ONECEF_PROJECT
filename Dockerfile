FROM odoo:18

# Copy your custom addons
COPY ./odoo_oncef /mnt/extra-addons

# Copy startup script
COPY start.sh /usr/local/bin/start.sh

USER root
RUN chmod +x /usr/local/bin/start.sh

USER odoo

CMD ["/usr/local/bin/start.sh"]