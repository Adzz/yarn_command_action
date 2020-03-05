#!/bin/sh

# Exit if any subcommand fails
set -e

# Setup node modules if needed
if [ -e node_modules/.bin/jest ]; then
    setup=""
else
    echo "## Your environment is not ready yet. Installing modules..."
    if [ -f yarn.lock ]; then
        setup="yarn --non-interactive --silent --ignore-scripts --production=false &&"
    else
        if [ -f package-lock.json ]; then
            setup="NODE_ENV=test npm ci --ignore-scripts &&"
        else
            setup="NODE_ENV=test npm install --no-package-lock --ignore-scripts &&"
        fi
    fi
fi

echo "## Running $1 $2 now"
sh -c "$setup $1 $2"
