# Setting up a Faucet

You need some tokens in an account you control for this.

## Build faucet and make a mnemonic

`./faucet.sh` will construct a docker image to run, and produce a unique mnemonic.

You want to copy the `FAUCET_MNEMOMIC=...` line and export it in your local shell

You also want to copy the `Created token holder` address and send some tokens there (like 100 SHELL):
`coral tx send reserve token_holder_address 100000000ushell --fees 5000ushell`

## Setup the faucet service

Make sure the FAUCET_MNEMONIC from the last part is `export`ed in your env and run:

`./services.sh`

Then check it:

```
systemctl status faucet
curl http://localhost:8000/status
```
