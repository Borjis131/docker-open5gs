#!/bin/bash

# AMF entrypoint

if [[ "${DISABLE_CHECKSUM_OFFLOADING}" == "TRUE" ]]; then
    ethtool -K eth0 rx off tx off
fi

# container entrypoint receiving arguments from Docker CMD
open5gs-amfd "${@}"
