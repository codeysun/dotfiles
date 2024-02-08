#!/bin/bash

app_name="nvim"

# Make sure that .local/bin/ is in PATH
line_to_append="export PATH=\"~/.local/bin:\$PATH\""
# Check if the line already exists in .bashrc
if grep -qF "$line_to_append" ~/.bashrc; then
  echo "~/.local/bin already in PATH"
else
  # If the line doesn't exist, append it to the end of .bashrc
  echo "$line_to_append" >> ~/.bashrc
  echo "~/.local/bin has been appended to ~/.bashrc."
  source ~/.bashrc
fi

# Check if Neovim is installed
if which "$app_name" >/dev/null; then
  echo "Neovim is already installed."
else
  # If the application is not found, install it
  echo "Neovim is not installed. Installing..."
  neovim_url="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
  install_dir="$HOME/.local/bin"
  mkdir -p "$install_dir"
  neovim_appimage="$install_dir/nvim.appimage"
  wget -qO "$neovim_appimage" "$neovim_url"
  chmod +x "$neovim_appimage"
  mv "$neovim_appimage" "$install_dir/nvim"
  echo "Installation complete."
fi

# TODO: Check if ripgrep is installed (for fuzzy finder)
if which "rg" >/dev/null; then
  echo "Ripgrep is already installed"
else
  echo "Ripgrep is not installed. Installing..."

# Nvim config file
# rm -rf $HOME/.config/nvim/
# ln -s `pwd`/configs/nvim/ $HOME/.config/nvim/
cp -r `pwd`/configs/nvim/ $HOME/.config/
