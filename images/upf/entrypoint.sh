#!/bin/bash

# UPF entrypoint

# source helper functions
source "helper_functions.sh"

# "${@}" contains the CMD provided by Docker

# setup container interfaces based on config file provided in Docker CMD
setup_container_interfaces "${@}"

# container entrypoint receiving arguments from Docker CMD
open5gs-upfd "${@}"
