#!/bin/bash
set -euo pipefail

# set all variables
WASMD_REPOSITORY=${REPOSITORY:-https://github.com/CosmWasm/wasmd}
WASMD_HOME="${WASMD_HOME:-/root/.wasmd}"
WASMD_SOURCE_DIR=${WASMD_SOURCE_DIR:-/etc/wasmd}
# cosmovisor is under cosmos-sdk
COSMOVISOR_REPO=${COSMOVISOR_REPO:-https://github.com/cosmos/cosmos-sdk}
COSMOVISOR_SOURCE_DIR=${COSMOVISOR_SOURCE_DIR:-/etc/cosmos-sdk}
COSMOVISOR_BINARY_DIR=${COSMOVISOR_BINARY_DIR:-/usr/local/bin}

if [ -z "$MONIKER" ]; then 
    echo You must set MONIKER to a unique node description
    exit 1
fi

if [ -z "$WASMD_VERSION" ]; then
    echo You must set WASMD_VERSION
    exit 1
fi

if [ -z "$COSMOVISOR_VERSION" ]; then
    echo You must set COSMOVISOR_VERSION
    exit 1
fi

# install deps
apt update
add-apt-repository ppa:longsleep/golang-backports -y
apt update
apt install -y build-essential golang-go git

# build wasmd
git clone $WASMD_REPOSITORY $WASMD_SOURCE_DIR && \
  cd $WASMD_SOURCE_DIR && \
  git checkout $WASMD_VERSION && \
  make build

# init wasmd home
$WASMD_SOURCE_DIR/build/wasmd init "$MONIKER"

# setup cosmovisor home
mkdir -p $WASMD_HOME/cosmovisor && \
  mkdir -p $WASMD_HOME/cosmovisor/genesis/bin && \
  mkdir -p $WASMD_HOME/cosmovisor/upgrades

# move wasmd to cosmovisor/genesis
mv $WASMD_SOURCE_DIR/build/wasmd $WASMD_HOME/cosmovisor/genesis/bin

# set symlink for cosmovisor/current
ln -s -T $WASMD_HOME/cosmovisor/genesis $WASMD_HOME/cosmovisor/current

# setup cosmovisor, build it and move the binary to root
git clone $COSMOVISOR_REPO $COSMOVISOR_SOURCE_DIR && \
  cd $COSMOVISOR_SOURCE_DIR/cosmovisor && \
  git checkout
  make cosmovisor && \
  mv cosmovisor $COSMOVISOR_BINARY_DIR

# and get the genesis file
curl -sSL "$GENESIS_URL" > "${WASMD_HOME}/config/genesis.json"

# get the app.toml config file
curl -sSL "$APP_CONFIG_URL" > "${WASMD_HOME}/config/app.toml"

sed -i "s,val_moniker,$MONIKER,g" "${WASMD_HOME}/config/app.toml"

# get the app.toml config file
curl -sSL "$CONFIG_URL" > "${WASMD_HOME}/config/config.toml"

# enable ssh, p2p
# maybe add prometheus when needed
ufw allow 22,26656,26657,9090,9091/tcp
