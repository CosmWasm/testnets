#!/bin/bash
set -euo pipefail

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/wasmd}
DOCKER="$REPOSITORY:$WASMD_VERSION"
WASMD_HOME="${WASMD_HOME:-/root}"
STAKE_COIN=$1
FEE_COIN=$2
COINS="${FEE_COIN},${STAKE_COIN}"

docker run --rm  \
    --mount type=bind,source="$WASMD_HOME",target=/root \
    $DOCKER $BINARY keys add wallet --keyring-backend file

docker run --rm  \
    --mount type=bind,source="$WASMD_HOME",target=/root \
    $DOCKER $BINARY add-genesis-account $(wasmd keys show -a wallet) $COINS --keyring-backend file

docker run --rm  \
    --mount type=bind,source="$WASMD_HOME",target=/root \
    $DOCKER $BINARY gentx wallet $STAKE_COIN --keyring-backend file
