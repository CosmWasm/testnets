# Setting up a code explorer


## Build code-explorer and deploy

Currently we deploy code-explorer very primitively but with the next deployments it will be scripted.
- clone https://github.com/CosmWasm/code-explorer
- follow https://github.com/CosmWasm/code-explorer#build-instructions
- copy the `build` folder contents to `/etc/code-explorer` with scp to the remote machine
- point domain `code-explorer.{DOMAIN}.cosmwasm.com` to the machine
- install nginx
- run certbot certonly --nginx -n -d code-explorer.${DOMAIN}
- copy [nginx/code-explorer.conf](nginx/code-explorer.conf) to `/etc/nginx/sites-enabled`
- restart nginx and the code-explorer will be ready
