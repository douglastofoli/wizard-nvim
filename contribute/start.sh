#!/usr/bin/env bash

# Colors
black='\e[0;30m' # Black - Regular
red='\e[0;31m' # Red
green='\e[0;32m' # Green
yellow='\e[0;33m' # Yellow
blue='\e[0;34m' # Blue
purple='\e[0;35m' # Purple
cyan='\e[0;36m' # Cyan
white='\e[0;37m' # White

WIZARD_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

BRANCH_NAME=wizard-nvim

if [ "$(docker ps -aq -f name=wizard-nvim-container)" ]; then
  echo
  echo -e "${yellow} - Cleaning up old container..."
  echo -e "${white}"

  # Cleanup
  docker rm wizard-nvim-container -f >> /dev/null
fi

# Ensure docker image exists
if [[ ! "$(docker images -q wizard-nvim-docker)" ]]; then
  echo 
  echo -e "${red} - Docker image does not exist." 
  echo -e "${green} - Building docker image..."
  echo -e "${white}"

  docker build -t wizard-nvim-docker .
fi

mkdir -p "$WIZARD_DIR"/workspace/local/share/nvim

chown -R $USER:$USER "$WIZARD_DIR"/workspace

docker run \
  -it \
  -e UID="$(id -u $USER)" \
  -e GID="$(id -u $USER)" \
  -v "$WIZARD_DIR"/../:/home/wizard/.config/nvim \
  -v "$WIZARD_DIR"/workspace:/home/wizard/workspace \
  -v "$WIZARD_DIR"/workspace/local/share/nvim:/home/wizard/.local/share/nvim \
  --name wizard-nvim-container \
  --user wizard \
  wizard-nvim-docker


