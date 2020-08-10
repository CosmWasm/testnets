# Set up a Full Node

## Installing

First, you must get the proper testnet config, eg: `source ../../coralnet/defaults.env`

Then you may want to set the following variables locally:

* `MONIKER` - this is the moniker you use for the node. it should be unique and descriptive (required)
* `WASMD_HOME` - this is the directory where all the data is stored. Default `/root`
* `REPOSITORY` - the docker image repository to use. Default `cosmwasm/wasmd` (maybe you have a fork?)

The script must be run as root. If you are not logged in as root, try `sudo -E install.sh`

Running this will set up all dependencies and create a local wasmd config for the proper testnet.

## Configuring

You will want to set up some nodes to connect to. The simplest (and restart safest) way to do so
is to edit `config/config.toml` in your chain-specific config dir.

You will want to set one or more of the following, all under `[p2p]`:

* `seeds` - a seed node to connect to for other peers
* `persistent_peers` - a peer to connect with everytime we restart
* `private_peers` - node_ids from above nodes that we do not want to gossip

## Systemd

If you wish to run this under systemd, then run `services.sh` to set up a default config to auto-restart the node.
This will install a service file with the binary name under eg `/etc/systemd/system/corald.service`,
enable it to start on reboot, and then start it running.

You may also run this manually or use another supervisor and skip this step. 