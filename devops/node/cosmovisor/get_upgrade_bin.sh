#!/bin/bash
set -euo pipefail

WASMD_SOURCE_DIR=${WASMD_SOURCE_DIR:-/etc/wasmd}
WASMD_HOME="${WASMD_HOME:-/root/.wasmd}"

cd $WASMD_SOURCE_DIR && \
  git checkout $NEW_VERSION && \
  make build && \
  mkdir -p $WASMD_HOME/cosmovisor/upgrades/$UPGRADE_NAME/bin && \
  mv $WASMD_SOURCE_DIR/build/wasmd $WASMD_HOME/cosmovisor/upgrades/$UPGRADE_NAME/bin
