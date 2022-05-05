# Scalr cdktf

How to get cdktf working with Scalr. Requires Scalr Pro tier for custom hook support.

This is very much a proof of concept and there are likely to be optimisations that will make the process more efficient.

# Setup

1.  Fork this repo.
1.  Create a VCS driven workspace in Scalr.
1.  Add a before plan custom hook of `./synth.sh`.
1.  Add a workspace shell variable `TF_CLI_ARGS_init` with value `"-backend-config=scalr-backend-config"`.
1.  Fill in [scalr-backend-config](./scalr-backend-config) with your environment specific details.
1.  Run it!

# How it works

Scalr does not have pre init hooks and so we must provide at least one HCL terraform file for the init to work. This file can be blank! To save on code duplication, the config is stored in `scalr-backend-config`. The env var `TF_CLI_ARGS_init` points terraform to this file.

The before plan hook takes care of most of the heavy lifting via the [synth.sh](./synth.sh) script. In brief this script:

1.  Downloads and "installs" node and npm
1.  Synthesises the cdktf to terraform json
1.  Moves the json plan to the correct location
1.  Reinits terraform (the `TF_CLI_ARGS_init` env var still applies here)

The standard Scalr workflow then takes care of the rest!
