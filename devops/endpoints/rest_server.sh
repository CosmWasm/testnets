#!/bin/bash
set -euo pipefail

ufw allow 22,80,443/tcp

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/wasmd}
DOCKER="$REPOSITORY:$WASMD_VERSION"
WASMD_HOME="${WASMD_HOME:-/root}"

if [ -z "$RPC_URL" ]; then 
    echo "You must set RPC_URL to an RPC endpoint"
    exit 1
fi

echo "Connecting rest server to $RPC_URL"

# install deps if needed
apt install -y docker.io
docker pull $DOCKER

SERVICE="${CLI_BINARY}-rest"
TARGET="/etc/systemd/system/${SERVICE}.service"

# copy service file and customize it
mv ./wasm-rest.service "${TARGET}"
sed -i "s/BINARY/$CLI_BINARY/g" "${TARGET}"
sed -i "s/SERVICE/$SERVICE/g" "${TARGET}"
# use , as separator, as $DOCKER and $WASMD_HOME use / internally
sed -i "s,DOCKER,$DOCKER,g" "${TARGET}"
sed -i "s,WASMD_HOME,$WASMD_HOME,g" "${TARGET}"
sed -i "s,RPC_URL,$RPC_URL,g" "${TARGET}"

systemctl enable "${SERVICE}"
systemctl start "${SERVICE}"

