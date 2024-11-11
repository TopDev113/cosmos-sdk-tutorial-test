#!/bin/bash
[ -d ~/.minid ] && rm -r ~/.minid

# Get current branch and latest commit hash
BRANCH=$(git rev-parse --abbrev-ref HEAD)
COMMIT=$(git log -1 --format='%H')

# Determine the VERSION
if [ -z "$VERSION" ]; then
  VERSION=$(git describe --exact-match 2>/dev/null || echo "$BRANCH-$COMMIT")
fi

# Define the ldflags
ldflags="-X github.com/cosmos/cosmos-sdk/version.Name=mini \
    -X github.com/cosmos/cosmos-sdk/version.AppName=minid \
    -X github.com/cosmos/cosmos-sdk/version.Version=$VERSION \
    -X github.com/cosmos/cosmos-sdk/version.Commit=$COMMIT"

run_minid() {
    go run -mod=readonly -ldflags="$ldflags" ./cmd/minid "$@"
}


# configure minid
run_minid config set client chain-id demo
run_minid config set client keyring-backend test
# Add keys
run_minid keys add alice
run_minid keys add bob

# Initialize chain
run_minid init test --chain-id demo --default-denom mini

# Update genesis
run_minid genesis add-genesis-account alice 10000000mini --keyring-backend test
run_minid genesis add-genesis-account bob 1000mini --keyring-backend test

# Create default validator
run_minid genesis gentx alice 1000000mini --chain-id demo
run_minid genesis collect-gentxs