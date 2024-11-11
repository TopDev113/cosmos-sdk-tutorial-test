#!/bin/bash

source ./scripts/minid_runner.sh
echo "-----------end round1 game transaction-------------"   
run_minid tx checkers end round1d --from alice --yes
echo "-----------end game result-------------"
run_minid query checkers get-game round1

