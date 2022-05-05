#!/bin/bash -e

# TODO: get LTS?
NODE_VERSION="16.15.0"
# TODO: support custom runners on other ARCHs
ARCH="x64"
uname -a

echo "downloading node"
curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.gz"
echo "creating temp folder"
mkdir -p /tmp/node
echo "extracting files"
tar -xzf "node-v$NODE_VERSION-linux-$ARCH.tar.gz" -C /tmp/node --strip-components=1 --no-same-owner
echo "updating PATH"
export PATH="$PATH:/tmp/node/bin"
echo "checking node version"
node --version
echo "checking npm version"
npm --version

# TODO: is there a cache anywhere?
echo "installing everything"
npm i
echo "synthesise"
# TODO: silence output
npm run synth
# cleanup (I think scalr saves the current working directory?)
echo "cleanup"
rm -rf node_modules
echo "moving files to top level"
# TODO: jq cdktf.out/manifest.json to programatically get name of stack & check support for multiple stacks
mv cdktf.out/stacks/cdk/* .
terraform init
