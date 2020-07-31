# Gaia Flex (WIP)

A permissionless network running on `wasd` 0.10

- **wasmd version**: `v0.10.0`
- **wasmd build command**: `make build-gaiaflex`
- **cosmosjs version**: `v0.22.0`
- **start**: 18th August 2020
- **end**: not yet finished

## Purpose

This is network demonstrates a gaia updated to launchpad with the x/wasm modules added along with governance controls on the contract lifecycle (uploading, instantiating, migrating).

## Connecting

The configuration can be [downloaded here](./config.env).
Please `source config` to get all variable you need.

With those, you can follow the
[official instructions](https://docs.cosmwasm.com/testnets/testnets.html)
 on how to connect to a testnet.
Or just connect your command-line client.

The [genesis file](./genesis.json) is also available here.

## Web endpoints

Here we list all explorers, wallets, and apps you can access with a browser:

* [Wasm Glass](https://demonet.wasm.glass) - contract explorer
* [Name App](https://cosmwasm.github.io/name-app/) - Sample dApp interface to use the 
  [nameservice contract](https://github.com/CosmWasm/cosmwasm-examples/tree/nameservice-0.5.2/nameservice) 
