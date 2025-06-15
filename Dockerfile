FROM odoo:18

# Copy your custom addons
COPY ./odoo_oncef /mnt/extra-addons

USER odoo

# Simple command that works with Render's environment variables
CMD ["sh", "-c", "odoo --addons-path=/mnt/extra-addons,/usr/lib/python3/dist-packages/odoo/addons --http-port=${PORT:-8069} --workers=0"]