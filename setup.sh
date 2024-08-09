#!/bin/bash

set -e
CONFIG_DIR=$(dirname "$0")

TARGET=$PWD

if [ "$CONFIG_DIR" =  "." ]; then
    echo "This script must be called from the floder where the links shall be created in" >&2
    exit 1
fi

function link ()
{
    ln -s "$CONFIG_DIR/$1" "$TARGET/$2"
}

link vscode .vscode
link devcontainer .devcontainer