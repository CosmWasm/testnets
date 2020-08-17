# Gaia Flex (WIP)

A permissionless network running on `wasd` 0.10

- **go version**: `1.14+`
- **wasmd version**: `v0.10.0`
- **wasmd build command**: `make build-gaiaflex`
- **CosmJS version**: `v0.22.1`
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


## Claiming the Airdrop

We do not have a faucet for `gaia-flex`, rather we did an airdrop to all cosmos addresses that
voted on Proposal #25. If you did, you need to follow these instructions to claim your airdrop
before you can start a validator or stake to an existing one.

We know that most of the voting keys are under high security (validator operator, staking keys), often 
on ledger devices or multisigs, and we DO NOT want any access to those keys with gaiaflex. Thus,
we worked out a process to claim the airdrop by only using these keys via `gaiacli` in offline mode.
The general procedure is:

1. Verify that your cosmos hub account has a balance on `gaia-flex` (call this hub address)
2. Create a new key with `gaiaflex` cli for use on this chain (call this testnet address)
3. Use `gaiaflex` to create an *unsigned tx* moving `umuon` from your hub address to your testnet address. **USE gaiaflex NOT gaiacli**
4. Copy unsigned tx to the machine with your cosmos hub keys and sign it using `gaiacli` in offline mode
5. Copy signed tx back to your laptop (or wherever) and broadcast it to `gaia-flex`

We assume `GAIA_KEYNAME` is set to the name of the key on your `gaiacli` keyring that you used for voting.
And `GAIA_ADDRESS` is set to the `cosmos...` address that voted on Proposal #25.

```shell
gaiaflex config node https://rpc.gaia-flex.cosmwasm.com:443
gaiaflex config trust-node true
```

Check the account, and get the account_number for later:

```shell
gaiaflex query account $GAIA_ADDRESS
ACCOUNT_NUMBER=$(gaiaflex query account $GAIA_ADDRESS -o json | jq -r .value.account_number)
echo $ACCOUNT_NUMBER
```

Create a new account and prepare a transaction:

```shell
gaiaflex keys add validator
gaiaflex tx send $GAIA_ADDRESS $(gaiaflex keys show -a validator) \
  9999000000umuon --fees 5000umuon --chain-id gaia-flex \
  --generate-only > airdrop.json
```

Copy `airdrop.json` to your secure computer with your `gaiacli` keychain, and sign.
Make sure you set `ACCOUNT_NUMBER` to the value above, and `GAIA_KEYNAME` to the proper name in the keyring:

```shell
gaiacli tx sign -a $ACCOUNT_NUMBER -s 0 --offline --from $GAIA_KEYNAME \
  --chain-id gaia-flex airdrop.json > airdrop_signed.json
```

Copy `airdrop_signed.json` back to the machine with the `gaiaflex` client, and submit it:

```shell
gaiaflex tx broadcast airdrop_signed.json
gaiaflex query account $(gaiaflex keys show -a validator)
```

You should have 9999 MUON now (`9999000000umuon`). Time to stake!

### Low security alternatives

If you don't have much stake on your cosmos hub account and you want a quick solution, you have two
choice, but you trust your cosmos hub private key to `gaiaflex` binary.

1. Use `gaiacli keys export (keyname) > (keyfile)` on your cosmos hub machine and later `gaiaflex keys import validator (keyfile)`
2. If you have your mnemonic `gaiaflex keys add -i validator`

I do not recommend these if you care much about the security of your Cosmos Hub key, but in theory they are not too
dangerous, more than moving the secret material around and trusting the `gaiaflex` binary.

## Staking your own validator

Make sure you set up a full node that is synced. Then get the validator pubkey from it via
`tendermint show-validator`. Set `VAL_PUBKEY` to this value (it starts with `cosmosvalconspub`).
Set `MONIKER` to whatever validator name you wish, like `funky-monkey`. Then run, this command
with your newly charged account:

```shell
gaiaflex tx staking create-validator \
  --amount=3000000000umuon \
  --pubkey=${VAL_PUBKEY} \
  --moniker=$MONIKER \
  --chain-id=gaia-flex \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
  --gas="400000" \
  --fees="20000umuon" \
  --from=validator
```

It will stake about 30% of your tokens on the validator, so you can spend other tokens, or stake them
on other validators (or yourself later). Shortly after this succeeds, you should see yourself
with `gaiaflex query staking validators` or on https://bigdipper.gaia-flex.cosmwasm.com/validators
