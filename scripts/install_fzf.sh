#!/bin/bash

app_name="fzf"

# Check if app is installed
if which "$app_name" >/dev/null; then
  echo "$app_name is already installed."
else
  # If the application is not found, install it
  echo "$app_name is not installed. Installing..."
  url="https://github.com/junegunn/fzf/releases/download/v0.56.3/fzf-0.56.3-linux_amd64.tar.gz"
  install_dir="$HOME/.local/bin"
  mkdir -p "$install_dir"
  app_tar="$install_dir/fzf.tar.gz"
  wget -qO "$app_tar" "$url"
  tar -xvf "$app_tar" -C "$install_dir"
  rm "$app_tar"
  echo "Installation complete."
fi

line_to_append="eval \"\$(fzf --bash)\""
# Check if the line already exists in .bashrc
if grep -qF "$line_to_append" ~/.bashrc; then
    echo "fzf already enabled in ~/.bashrc"
else
    # If the line doesn't exist, append it to the end of .bashrc
    echo "$line_to_append" >> ~/.bashrc
    echo "fzf enabled in ~/.bashrc"
fi
