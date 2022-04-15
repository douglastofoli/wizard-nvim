FROM archlinux:latest

LABEL maintainer="Douglas Tofoli <contact@douglastofoli.dev>"

ENV UID="1000" \
  GID="1000" \
  UNAME="wizard" \
  GNAME="wizard" \
  SHELL="/bin/sh" \
  WORKSPACE="" \
  NVIM_CONFIG="/home/wizard/.config/nvim" \
  PATH="/home/wizard/.local/bin:${PATH}"

# Update repositories
RUN pacman -Syy

# Install Neovim
RUN pacman -Sy neovim --noconfirm

# Install runtime dependencies
RUN pacman -Sy ripgrep nodejs-lts-gallium npm git bash gcc jq --noconfirm

# Install required dependencies for LSP Installer
RUN pacman -Sy wget unzip --noconfirm

RUN groupadd wizard
RUN useradd -m -g wizard wizard

RUN mkdir /usr/local/lib/node_modules
RUN chown -R ${UNAME}:${GNAME} /usr/local/lib/node_modules/

RUN npm i -g chokidar-cli

USER wizard
WORKDIR /home/wizard

COPY _docker_entry.sh /usr/local/bin/

# Wizard-nvim
VOLUME "~/.config/nvim"
# For storing packer plugins
VOLUME "~/.local/share/nvim"
# Files and projects for testing on disk
VOLUME "~/workspace"


ENTRYPOINT ["sh", "/usr/local/bin/_docker_entry.sh"]

