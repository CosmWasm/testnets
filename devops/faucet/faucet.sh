#!/bin/bash
set -euo pipefail

# allow only ssh and http ports
ufw allow 22,80,443/tcp

# TODO: configure this better.. this is the bech32 prefix for the chain
PREFIX=${PREFIX:-coral}

# Note: this requires the ../endpoints scripts to have been run locally before
# and the various deps (certbot, nginx, etc) already set up.
# If you want to run this separately, there is some more setup needed

docker build -t cosmwasm/faucet:manual .

docker run --rm cosmwasm/faucet:manual cosmwasm-faucet version

docker run -e FAUCET_ADDRESS_PREFIX=coral --rm cosmwasm/faucet:manual cosmwasm-faucet generate
