# Set up a Full Node

## Installing

First, you must get the proper testnet config, eg: `source ../coralnet/defaults.env`

Then you may want to set the following variables locally:

* `WASMD_HOME` - this is the directory where all the data is stored. Default `/root`
* `REPOSITORY` - the docker image repository to use. Default `cosmwasm/wasmd` (maybe you have a fork?)

The script must be run as root. If you are not logged in as root, try `sudo -E install.sh`