#!/bin/bash

# Exit immediately if a command exits with a non-zero status, 
# and print each command before execution
set -ex

# Force LF line-endings
# https://tinyurl.com/line-endings
git config --local core.eol lf
git config --local core.autocrlf input

# Remove the existing `.uv_cache` directory if it exists, 
# suppress any errors using `true` in case the directory doesn't exist.
rm -rf /home/$USER/.uv_cache | true

# Create a new `.uv_cache` directory to store cache data
mkdir /home/$USER/.uv_cache | true

# Sync the UV environment to ensure it's up-to-date
uv sync --all-groups

# Install pre-commit hooks using the pre-commit package
uv run pre-commit install