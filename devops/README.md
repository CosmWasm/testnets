# Dev Ops

This contains some sample scripts that you can use to quickly pull up a node for a testnet.
They are designed for ease of use and simplicity rather than complexity. This is just bash scripts,
designed for Ubuntu, so they should be easy to port to any other system.

Some changes you may wish to make if you deploy this on a value-bearing network:

* Use native binaries rather than docker
* Activate a firewall
* Use hardware key signer
* Further tune the node's config.toml
* Further OS-level security updates

However, for early testnets this should be enough to get started.

## Setup

All scripts rely heavily on environment variables to work correctly.
You will want to `source ../<testnetname>/defaults.env` as a basis, then
possibly declare a few more variables as desired.

## Scripts

[Full Node](./node) - will help you start up a full node connected to a running network. Once this
is synced up, you can stake to make it a validator.

[Public Endpoints](./endpoints) - will help you set up ssl certs and nginx config to serve rpc and lcd
endpoints over https.

[Faucet](./faucet) - Also, you can optionally set up a faucet. However, you need to feed it with tokens
so it has something to give out.