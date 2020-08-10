#!/bin/bash
set -euo pipefail

apt install -y nginx certbot python3-certbot-nginx

echo n | certbot register --agree-tos -m ${EMAIL}
certbot certonly --nginx -n -d rpc.${DOMAIN}
certbot certonly --nginx -n -d lcd.${DOMAIN}

# process the variables in sites-enabled
for file in $(ls nginx | grep -v proxy); do
    FILE="nginx/${file}"
    sed -i s/DOMAIN/${DOMAIN}/g $FILE
    sed -i s,RPC_URL,${RPC_URL},g $FILE
done  

# copy over nginx configs
mv ./nginx/proxy.conf /etc/nginx/conf.d
mv ./nginx/*.conf /etc/nginx/sites-enabled

nginx -t
systemctl restart nginx
