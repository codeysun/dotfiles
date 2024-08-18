#!/bin/bash

app_name="oh-my-posh"

# Check if oh-my-posh is already installed
if which "$app_name" >/dev/null; then
  echo "oh-my-posh is already installed."
else
  # If the application is not found, install it
  echo "oh-my-posh is not installed. Installing..."
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
  echo "Installation complete."
fi

# Use catppuccin by default
line_to_append="eval \"\$(oh-my-posh init bash --config `pwd`/configs/omp/rosepine.omp.json)\""
# Check if the line already exists in .bashrc
if grep -qF "$line_to_append" ~/.bashrc; then
    echo "oh-my-posh colorscheme already enabled in ~/.bashrc"
else
    # If the line doesn't exist, append it to the end of .bashrc
    echo "$line_to_append" >> ~/.bashrc
    echo "oh-my-posh colorscheme enabled in ~/.bashrc"
fi
