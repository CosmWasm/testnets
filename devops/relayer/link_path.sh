#!/bin/bash
set -euo pipefail

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/relayer}
RELAYER_VERSION=${RELAYER_VERSION:-latest}
DOCKER="$REPOSITORY:$RELAYER_VERSION"
RELAYER_HOME="${RELAYER_HOME:-/root/.relayer}"

PATH_NAME=$1

docker run --rm  \
  --mount type=bind,source="$RELAYER_HOME",target=/root/.relayer \
  $DOCKER tx link $PATH_NAME
