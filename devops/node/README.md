# Set up a Full Node

## Installing

First, you must get the proper testnet config, eg: `source ../../coralnet/defaults.env`

Then you may want to set the following variables locally:

* `MONIKER` - this is the moniker you use for the node. it should be unique and descriptive (required)
* `WASMD_HOME` - this is the directory where all the data is stored. Default `/root`
* `REPOSITORY` - the docker image repository to use. Default `cosmwasm/wasmd` (maybe you have a fork?)

The script must be run as root. If you are not logged in as root, try `sudo -E install.sh`

Running this will set up all dependencies and create a local wasmd config for the proper testnet.

## Systemd

If you wish to run this under systemd, then run `services.sh` to set up a default config to auto-restart the node.