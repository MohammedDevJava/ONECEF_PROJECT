FROM odoo:18

# Copy your custom addons
COPY ./odoo_oncef /mnt/extra-addons

# Create a custom configuration
USER root
RUN echo '[options]\n\
addons_path = /mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons\n\
data_dir = /var/lib/odoo\n\
admin_passwd = admin\n\
db_maxconn = 64\n\
limit_memory_hard = 2684354560\n\
limit_memory_soft = 2147483648\n\
limit_request = 8192\n\
limit_time_cpu = 600\n\
limit_time_real = 1200\n\
max_cron_threads = 1\n\
workers = 0' > /etc/odoo/odoo.conf

USER odoo

# Expose the port that Render expects
EXPOSE $PORT

# Start command that uses environment variables
CMD ["sh", "-c", "odoo --config=/etc/odoo/odoo.conf --db_host=$DB_HOST --db_port=$DB_PORT --db_user=$DB_USER --db_password=$DB_PASSWORD --http-port=$PORT --workers=0"]