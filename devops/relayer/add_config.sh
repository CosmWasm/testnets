#!/bin/bash
set -euo pipefail

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/relayer}
RELAYER_VERSION=${RELAYER_VERSION:-latest}
DOCKER="$REPOSITORY:$RELAYER_VERSION"
RELAYER_HOME="${RELAYER_HOME:-/root/.relayer}"
CONFIG_DIR="${CONFIG_DIR:-/root/configs}"

# add configurations
docker run --rm  \
    --mount type=bind,source="$RELAYER_HOME",target=/root/.relayer \
    --mount type=bind,source="$CONFIG_DIR",target=/root/configs \
    $DOCKER config add-dir /root/configs
