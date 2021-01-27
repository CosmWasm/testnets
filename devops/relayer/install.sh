#!/bin/bash
set -euo pipefail

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/relayer}
RELAYER_VERSION=${RELAYER_VERSION:-latest}
DOCKER="$REPOSITORY:$RELAYER_VERSION"
RELAYER_HOME="${RELAYER_HOME:-/root/.relayer}"
CONFIG_DIR="${CONFIG_DIR:-/root/configs}"

# install deps
apt update
apt install -y docker.io jq
docker pull $DOCKER

mkdir $RELAYER_HOME

# initialize relayer config
docker run --rm  \
    --mount type=bind,source="$RELAYER_HOME",target=/root/.relayer \
    $DOCKER config init

# enable ssh
ufw allow 22
