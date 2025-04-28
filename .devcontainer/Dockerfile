# Use the base image from Microsoft as the starting point for the dev container
FROM mcr.microsoft.com/devcontainers/base:debian-12

# Clean the apt package cache
RUN apt-get clean && \
    # Update package lists
    apt-get update && \
    # Install essential development dependencies
    apt-get install -y \
        libsasl2-dev libldap2-dev libssl-dev libsnmp-dev libffi-dev \
        libncurses-dev libsqlite3-dev libbz2-dev libreadline-dev \ 
        liblzma-dev tzdata libfontconfig1:arm64 librsvg2-bin \
    && rm -rf /var/lib/apt/lists/* && \
    # Download and install the Quarto .deb package in one command
    wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.42/quarto-1.6.42-linux-arm64.deb -O /tmp/quarto.deb && \
    dpkg -i /tmp/quarto.deb && \
    apt-get install -f -y && \
    rm /tmp/quarto.deb && \
    wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh 

# Set general-purpose environment variables for the dev container user
ENV HOME="/home/vscode"
ENV UV_CACHE_DIR="/home/vscode/.uv_cache"

# Switch to the 'vscode' user for the rest of the build
# Standard user in dev containers
USER vscode

# Set the working directory to the user's home
WORKDIR /home/vscode

# Copy the 'uv' and 'uvx' executables from the UV container image into this container
# https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
COPY --from=ghcr.io/astral-sh/uv:debian /usr/local/bin/uv /usr/local/bin
COPY --from=ghcr.io/astral-sh/uv:debian /usr/local/bin/uvx /usr/local/bin

# Install the specified version of Python using uv
RUN uv python install 3.11