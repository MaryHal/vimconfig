#!/bin/sh

pushd bundle
find . -maxdepth 1 -type d -exec sh -c '(cd {} && pwd && git pull)' ';'
popd
