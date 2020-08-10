#!/bin/bash
set -euo pipefail

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/wasmd}
DOCKER="$REPOSITORY:$WASMD_VERSION"
WASMD_HOME="${WASMD_HOME:-/root}"

docker run --rm  \
    --mount type=bind,source="$WASMD_HOME",target=/root \
    $DOCKER $BINARY tendermint show-node-id
