#!/bin/bash
set -euo pipefail

apt install -y nginx certbot python3-certbot-nginx
echo n | certbot register --agree-tos -m ${EMAIL}
certbot certonly --nginx -n -d block-explorer.${DOMAIN}

# process the variables in sites-enabled
for FILE in nginx/*.conf; do
    sed -i s/DOMAIN/${DOMAIN}/g $FILE
done  

# copy over nginx configs
mv ./nginx/*.conf /etc/nginx/sites-enabled

nginx -t
systemctl restart nginx
