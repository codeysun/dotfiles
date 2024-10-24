#!/bin/bash

app_name="tmux"

# Check if tmux is installed
if which "$app_name" >/dev/null; then
  echo "tmux is already installed."
else
  # If the application is not found, install it
  echo "tmux is not installed. Installing..."
  tmux_url="https://github.com/nelsonenzo/tmux-appimage/releases/download/3.3a/tmux.appimage"
  install_dir="$HOME/.local/bin"
  mkdir -p "$install_dir"
  tmux_appimage="$install_dir/tmux.appimage"
  wget -qO "$tmux_appimage" "$tmux_url"
  chmod +x "$tmux_appimage"
  mv "$tmux_appimage" "$install_dir/tmux"
  echo "Installation complete."
fi

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Tmux config file
rm -rf $HOME/.tmux.conf
ln -s `pwd`/configs/tmux/tmux.conf $HOME/.tmux.conf
