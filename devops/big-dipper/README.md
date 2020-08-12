# Set up a Block explorer

These instructions work for a machine running Ubuntu 20.04.

First, copy all files from this directory to the machine:

`scp -r ./* root@1.2.3.4:/root`

Also, copy the proper settings for the testnet you choose:

`scp ../../coralnet/big-dipper-settings.json root@1.2.3.4:/root/settings.json`

## Installing

The script must be run as root. If you are not logged in as root, try `sudo -E install.sh`

Running this will set up all dependencies, block-explorer clone repo, build image.

## Nginx

Before setting up nginx make sure you exported these variables

- `EMAIL` - an email for a sysadmin, used with let's encrypt when registering ssl certificates
- `DOMAIN` - the root domain we register under. We will try to set up ssl services for

then `sudo -E ./nginx.sh` will do its magic.

## Systemd

If you wish to run this under systemd, then run `services.sh` to set up a default config to auto-restart the node.
This will install a service file with the binary name under eg `/etc/systemd/system/big-dipper.service`,
enable it to start on reboot, and then start it running.

You may also run this manually or use another supervisor and skip this step.
