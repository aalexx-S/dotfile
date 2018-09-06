#!/bin/bash
#
# This script is created by ejmr.
# https://gist.github.com/ejmr/a927d32e25488a282bd3
#
# You can use `git branch --edit-description` to write a description
# for a branch, but Git provides no simple command to display that
# description.  The "easiest" way to see it is via `git config --get
# branch.BRANCH_NAME.description`.
#
# This script automates that process and is meant to be used as
# a Git alias to provide a shorter command for showing the
# description of the current branch.
#
#######################################################################

BRANCH="$(git symbolic-ref --short HEAD)"
DESCRIPTION_PROPERTY="branch.${BRANCH}.description"
git config --get "$DESCRIPTION_PROPERTY"
