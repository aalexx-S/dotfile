# download h if not exist
if [[ ! -f ~/h.sh ]] ; then
	echo "Downloading h, a better grep highlighter tool build on ack."
	set -x
	curl https://raw.githubusercontent.com/dczhu/mch/master/h > ~/h.sh
	{ set +x; } 2>/dev/null
fi

# download cxpgrep if not exist
if [[ ! -f ~/cxpgrep.sh ]] ; then
	echo "Downloading cxpgrep, a grep wrapper."
	set -x
	curl https://raw.githubusercontent.com/dczhu/cxpgrep/master/cxpgrep > ~/cxpgrep.sh
	{ set +x; } 2>/dev/null
fi

# download ltcd if not exist
if [[ ! -f ~/ltcd.sh ]] ; then
	echo "Downloading ltcd, a cd wrapper."
	set -x
	curl https://raw.githubusercontent.com/dczhu/ltcd/master/ltcd > ~/ltcd.sh
	{ set +x; } 2>/dev/null
fi

# install node.js for Coc, vim completion engine
curl -sL install-node.now.sh/lts | sudo bash
