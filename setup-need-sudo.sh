# install node.js for Coc, vim completion engine
# may need permission.
if [[ "$EUID" -ne 0 ]]; then
	echo "Install node.js requires root permission. Exiting."
else
	curl -sL install-node.now.sh/lts | bash
fi
