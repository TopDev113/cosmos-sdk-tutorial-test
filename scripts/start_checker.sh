#!/bin/bash

source ./scripts/minid_runner.sh
echo "------------keytest-------------"
run_minid keys list --keyring-backend test
echo "-----------create round1 game -------------"
run_minid tx checkers create round1 \
    mini16ajnus3hhpcsfqem55m5awf3mfwfvhpp36rc7d \
    mini1hv85y6h5rkqxgshcyzpn2zralmmcgnqwsjn3qg \
    --from alice --yes
# echo "-----------end round1 game transaction-------------"   
# run_minid tx checkers end round1d
echo "-----------start game result-------------"
run_minid query checkers get-game round1

