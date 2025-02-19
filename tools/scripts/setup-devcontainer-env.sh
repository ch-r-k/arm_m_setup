#!/bin/bash

## set jlink ip address
export HOST_IP=$(getent ahostsv4 host.docker.internal | head -n 1 | awk '{print $1}')
echo "set(JLINK_IP \"$HOST_IP\")" > jlink_ip.cmake