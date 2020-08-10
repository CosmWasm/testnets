#!/bin/bash
set -euo pipefail

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/wasmd}
DOCKER="$REPOSITORY:$WASMD_VERSION"

WASMD_HOME="${WASMD_HOME:-/root}"

# install deps
apt update
apt install -y docker.io
docker pull $DOCKER

# set up the private data
docker run --rm  \
    --mount type=bind,source="$WASMD_HOME",target=/root \
    $DOCKER $BINARY init

# and get the genesis file
curl -sSL "$GENESIS_URL" > "{$WASM_HOME}/config/genesis.json"

# TODO: do this more selectively
# disable firewall completely so all p2p/rpc ports are open
ufw disable
