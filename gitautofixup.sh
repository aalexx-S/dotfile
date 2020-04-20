#!/bin/bash

# auto fixup if commit message is "ff"
sed -i -r 's/pick\ (.{7} ff)/f \1/' $1
