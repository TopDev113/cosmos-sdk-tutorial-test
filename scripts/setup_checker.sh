#!/bin/bash

# Remove existing .minid directory if it exists
[ -d ~/.minid ] && rm -r ~/.minid

# Source the utility script to load the run_minid function and variables
source ./scripts/minid_runner.sh

echo "-----------Configure minid----------"
run_minid config set client chain-id demo
run_minid config set client keyring-backend test

echo "---------Add keys----------"
run_minid keys add alice
run_minid keys add bob

echo "------Initialize chain------------"
run_minid init test --chain-id demo --default-denom mini

echo "-----Update genesis-----"
run_minid genesis add-genesis-account alice 10000000mini --keyring-backend test
run_minid genesis add-genesis-account bob 1000mini --keyring-backend test

echo  "----Create default validator------"
run_minid genesis gentx alice 1000000mini --chain-id demo
run_minid genesis collect-gentxs

echo  "----Setup environment------"
run_minid start
