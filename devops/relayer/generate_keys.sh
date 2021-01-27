#!/bin/bash
set -euo pipefail

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/relayer}
RELAYER_VERSION=${RELAYER_VERSION:-latest}
DOCKER="$REPOSITORY:$RELAYER_VERSION"
RELAYER_HOME="${RELAYER_HOME:-/root/.relayer}"

CHAIN_ID=$1
KEY_NAME=$2

docker run --rm  \
  --mount type=bind,source="$RELAYER_HOME",target=/root/.relayer \
  $DOCKER keys add $CHAIN_ID $KEY_NAME
