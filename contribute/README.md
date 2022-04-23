# Contributing Tool

To easily start to make code for this project, you can use the files within this directory.

# Start Container

At the first time will be necessary to build the image before run the container. But wait, you can use the script start.sh to help you. Just run on the shell:

```sh
./start.sh
```

_The build takes about 1 minute to finish._

# Project Structure

```
nvim/
├─ lua/
│  ├─ wizard/       # the project of IDE layer
│  │  ├─ core/      # system variables, load configs, load modules of core
│  │  ├─ extras/    # auto commands, keybindings, logs...
│  │  ├─ modules/   # all plugins is configured and loaded here
│  │  ├─ utils/     # some utilities that be very usefull (converters, loaders...)
├─ init.lua         # is the major entrypoint 
├─ contribute/      # Dockerfile for contribute with the project is here
```

# Directories 

Within `contribute` directory you will see another directory called `workspace`. Inside it you can put your personal scripts to test within the Docker container. There too will store the data of `~/.local/share/nvim`.

The code modifications made to the root if your clone will immediately reflect inside the container. Just close the neovim of the container and open again to see. **Don't need to reload the container**.
