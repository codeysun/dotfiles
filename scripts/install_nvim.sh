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

# Install ripgrep
if which "rg" >/dev/null; then
  echo "Ripgrep is already installed."
else
  # If the application is not found, install it
  echo "Ripgrep is not installed. Installing..."
  ripgrep_url="https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz"
  install_dir="$HOME/.local/bin"
  mkdir -p "$install_dir"
  rg_tar="ripgrep.tar.gz"
  wget -qO "$rg_tar" "$ripgrep_url"
  tar -xvf "ripgrep.tar.gz"
  mv "ripgrep-14.1.0-x86_64-unknown-linux-musl/rg" "$install_dir"
  rm "ripgrep.tar.gz"
  rm -rf "ripgrep-14.1.0-x86_64-unknown-linux-musl/rg"
  echo "Installation complete."
fi

# # Install npm
# if which "rg" >/dev/null; then
#   echo "Ripgrep is already installed."
# else
#   # If the application is not found, install it
#   echo "Installation complete."
# fi

# Nvim config file
# rm -rf $HOME/.config/nvim/
# ln -s `pwd`/configs/nvim/ $HOME/.config/nvim/
cp -r `pwd`/configs/nvim/ $HOME/.config/
