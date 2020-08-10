# Public Endpoints

This will set up an rpc and an lcd server behind https, using nginx as a proxy. Also handling CORS issues.

You need to first have access to an RPC endpoint, either on this machine, or another machine
you own. Check out [setting up a full node](`../node`) to see how to run your own node and
expose an RPC endpoint.

First, copy all files from this directory to the machine:

`scp -r ./* root@1.2.3.4:`

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

You should already have the rest server running locally, and the `defaults.env` variables in your shell.

Then you will want to set the following variables locally:

* `EMAIL` - an email for a sysadmin, used with let's encrypt when registering ssl certificates
* `DOMAIN` - the root domain we register under. We will try to set up ssl services for
  `rpc.$DOMAIN` and `lcd.$DOMAIN`. Both these DNS records must point to the current machine
* `RPC_URL` - this is the RPC URL we connect to for serving the data. (same one the rest server uses)

Run it like:

```bash
export EMAIL=hello@my.com
export DOMAIN=coral.my.com
export RPC_URL=http://localhost:26657/
./nginx.sh
```

After this is done, you should be able to query the https endpoints:

```bash
curl https://rpc.DOMAIN/status
curl https://lcd.DOMAIN/node_info
```
