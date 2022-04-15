#!/usr/bin/env bash

echo "alias wwhatch=\"chokidar '/home/wizard/.config/nvim/**/*.lua' -t 100 -c 'debounce 1 | nvim'\"" >> ~/.bashrc

echo "nvim" >> ~/.bashrc

cd ~/workspace

bash
