#!/bin/bash

# need permission.
if [[ "$EUID" -ne 0 ]]; then
	echo "Install node.js requires root permission. Exiting."
	exit 1

# update and upgrade
apt update && apt upgrade

# install locate
apt install locate

# install node.js for Coc, vim completion engine
curl -sL install-node.now.sh/lts | bash

# install pip3
apt install python3-pip

# install pylint
pip3 install pylint --user

# install jedi
pip3 install jedi --user

# install bash language server
npm i -g bash-language-server
