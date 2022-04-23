FROM archlinux:latest

LABEL maintainer="Douglas Tofoli <contact@douglastofoli.dev>"

ENV UID="1000" \
  GID="1000" \
  UNAME="wizard" \
  GNAME="wizard" \
  SHELL="/bin/bash" \
  WORKSPACE="" \
  NVIM_CONFIG="/home/wizard/.config/nvim" \
  PATH="/home/wizard/.local/bin:${PATH}"

# Update repositories
RUN pacman -Syy

# Install Neovim
RUN pacman -S neovim --noconfirm

# Install runtime dependencies
RUN pacman -S ripgrep git gcc jq xclip --noconfirm

# Install required dependencies for LSP Installer
RUN pacman -S wget unzip --noconfirm

# Install nodejs LTS 16.14.x 
RUN pacman -S nodejs-lts-gallium npm --noconfirm

RUN mkdir /usr/local/lib/node_modules
RUN chown -R ${UNAME}:${GNAME} /usr/local/lib/node_modules/

# Create group and user wizard
RUN groupadd -g ${GID} wizard
RUN useradd -u ${UID} -m -g wizard wizard

USER wizard
WORKDIR /home/wizard

COPY _entrypoint.sh /usr/local/bin/

# Nvim configs
VOLUME "~/.config/nvim"
# Packer plugins store 
VOLUME "~/.local/share/nvim"
# Personal files to test
VOLUME "~/workspace"

ENTRYPOINT ["sh", "/usr/local/bin/_entrypoint.sh"]

