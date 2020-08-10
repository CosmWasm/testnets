#!/bin/bash
set -euo pipefail

# Note: this requires the ../endpoints scripts to have been run locally before
# and the various deps (certbot, nginx, etc) already set up.
# If you want to run this separately, there is some more setup needed

docker build -t cosmwasm/faucet:manual .

docker run --rm cosmwasm/faucet:manual cosmwasm-faucet version
