#!/bin/bash
set -euo pipefail

# set all variables
WASMD_HOME="${WASMD_HOME:-/root/.wasmd}"
COSMOVISOR_BINARY_DIR=${COSMOVISOR_BINARY_DIR:-/usr/local/bin}

$COSMOVISOR_BINARY_DIR/cosmovisor tendermint show-validator --home $WASMD_HOME
