#!/bin/bash

app_name="yazi"

# Check if app is installed
if which "$app_name" >/dev/null; then
  echo "$app_name is already installed."
else
  # If the application is not found, install it
  echo "$app_name is not installed. Installing..."
  url="https://github.com/sxyazi/yazi/releases/download/v0.4.2/yazi-x86_64-unknown-linux-gnu.zip"
  install_dir="$HOME/.local/bin"
  mkdir -p "$install_dir"
  wget "$url"
  unzip yazi-x86_64-unknown-linux-gnu.zip
  mv yazi-x86_64-unknown-linux-gnu/ya "$install_dir"
  mv yazi-x86_64-unknown-linux-gnu/yazi "$install_dir"
  rm -rf yazi-x86_64-unknown-linux-gnu
  rm yazi-x86_64-unknown-linux-gnu.zip
  echo "Installation complete."
fi
