#!/usr/bin/env bash

CONTRIBUTE_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

BRANCH_NAME=wizard-nvim

# Ensure docker image exists
if [[ ! "$(docker images -q wizard-nvim-docker)" ]]; then
  echo " - Docker image does not exist.  Building docker image..."
  docker build -t wizard-nvim-docker .
fi

if [ "$(docker ps -aq -f status=exited -f name=wizard-nvim-container)" ]; then
  echo " - Cleaning up old container..."
  # cleanup
  docker rm wizard-nvim-container >> /dev/null
fi

mkdir -p "$CONTRIBUTE_DIR"/workspace/local/share/nvim

chown -R $USER:$USER "$CONTRIBUTE_DIR"/../
chown -R $USER:$USER "$CONTRIBUTE_DIR"/workspace/local/share/nvim

docker run \
  -it \
  -e UID="1000" \
  -e GID="1000" \
  -v "$CONTRIBUTE_DIR"/../:/home/wizard/.config/nvim \
  -v "$CONTRIBUTE_DIR"/workspace:/home/wizard/workspace \
  -v "$CONTRIBUTE_DIR"/workspace/local/share/nvim:/home/wizard/.local/share/nvim \
  --name wizard-nvim-container \
  --user wizard \
  wizard-nvim-docker


