#!/bin/bash

# Define the ldflags
BRANCH=$(git rev-parse --abbrev-ref HEAD)
COMMIT=$(git log -1 --format='%H')

# Determine the VERSION
if [ -z "$VERSION" ]; then
  VERSION=$(git describe --exact-match 2>/dev/null || echo "$BRANCH-$COMMIT")
fi

ldflags="-X github.com/cosmos/cosmos-sdk/version.Name=mini \
    -X github.com/cosmos/cosmos-sdk/version.AppName=minid \
    -X github.com/cosmos/cosmos-sdk/version.Version=$VERSION \
    -X github.com/cosmos/cosmos-sdk/version.Commit=$COMMIT"

# Define the run_minid function
run_minid() {
    go run -mod=readonly -ldflags="$ldflags" ./cmd/minid "$@"
}
