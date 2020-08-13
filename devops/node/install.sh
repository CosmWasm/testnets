#!/bin/bash
set -euo pipefail

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/wasmd}
DOCKER="$REPOSITORY:$WASMD_VERSION"
WASMD_HOME="${WASMD_HOME:-/root}"

if [ -z "$MONIKER" ]; then 
    echo You must set MONIKER to a unique node description
    exit 1
fi

# install deps
apt update
apt install -y docker.io
docker pull $DOCKER

# set up the private data
docker run --rm  \
    --mount type=bind,source="$WASMD_HOME",target=/root \
    $DOCKER $BINARY init "$MONIKER"

# and get the genesis file
curl -sSL "$GENESIS_URL" > "${WASMD_HOME}/${CONFIG_DIR}/config/genesis.json"

# get the app.toml config file
curl -sSL "$APP_CONFIG_URL" > "${WASMD_HOME}/${CONFIG_DIR}/config/app.toml"

# TODO: do this more selectively
# disable firewall completely so all p2p/rpc ports are open
ufw disable
