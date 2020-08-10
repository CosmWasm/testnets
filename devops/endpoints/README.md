# Public Endpoints

This will set up an rpc and an lcd server behind https, using nginx as a proxy. Also handling CORS issues.

You need to first have access to an RPC endpoint, either on this machine, or another machine
you own. Check out [setting up a full node](`../node`) to see how to run your own node and
expose an RPC endpoint.

First, copy all files from this directory to the machine:

`scp ./* root@1.2.3.4:`

Also, copy the proper env for the testnet you choose:

`scp ../../coralnet/defaults.env root@1.2.3.4:`

# Rest Server

We will run a rest server locally, which connects to the rpc server above and presents a
nicer API for Javascript clients.

First, source all the defaults: `source defaults.env`

Then you may want to set the following variables locally:

* `RPC_URL` - this is the RPC URL we connect to for serving the data. It should be trusted (required)
* `WASMD_HOME` - this is the directory where all the data is stored. Default `/root`

Then run it like: `RPC_URL=http://localhost:26657 ./rest_server.sh`

When this is up, `systemctl status coral-rest` or whatever testnet it is for, should show success.
And `curl http://localhost:1317/node_info` should return good results.


# Nginx

First, source all the defaults: `source defaults.sh`

Then you may want to set the following variables locally:

* `MONIKER` - this is the moniker you use for the node. it should be unique and descriptive (required)
* `WASMD_HOME` - this is the directory where all the data is stored. Default `/root`
* `REPOSITORY` - the docker image repository to use. Default `cosmwasm/wasmd` (maybe you have a fork?)
