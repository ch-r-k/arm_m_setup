#!/bin/bash
export HOST_IP=$(getent ahostsv4 host.docker.internal | head -n 1 | awk '{print $1}')
echo "set(JLINK_IP \"$HOST_IP\")" > jlink_ip.cmake

# Required for firmware signing
#pip3 install -r tools/firmware-signing/requirements.txt