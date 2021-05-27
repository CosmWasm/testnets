#!/bin/bash
set -euo pipefail

# install deps
apt update
apt install -y docker.io docker-compose jq

docker-compose pull

METEOR_SETTINGS=$(jq -c < ./block-explorer-settings.json)
APP_ROOT_URL="https://block-explorer.${DOMAIN}"

echo "METEOR_SETTINGS=${METEOR_SETTINGS}" > .env
echo "APP_ROOT_URL=${APP_ROOT_URL}" >> .env
