# Sofle Board 

## Setup

Following [zmk-tutorial](https://zmk.dev/docs/user-setup)

1. Repo was created in github
2. `bash -c "$(curl -fsSL https://zmk.dev/setup.sh)"`
3. 70,10,y,gbakes,git@github.com:gbakes/zmk_sofle2.git,y

Using [web gui](https://nickcoutsos.github.io/keymap-editor/) for config

## Flashing

1. cd into local_build
2. make sure .env has token set from [url](https://github.com/settings/tokens)
3. Connect board and enter bootloader
4. run `sh flash.sh`

