#!/bin/bash

app_name="oh-my-posh"

OS="$(uname)"
if [[ "$OS" == "Darwin" ]]; then
  RCFILE="$HOME/.zshrc"
  SHELL_NAME="zsh"
else
  RCFILE="$HOME/.bashrc"
  SHELL_NAME="bash"
fi

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
line_to_append="eval \"\$(oh-my-posh init $SHELL_NAME --config `pwd`/configs/omp/rosepine.omp.json)\""
# Check if the line already exists in the shell rc file
if grep -qF "$line_to_append" "$RCFILE"; then
    echo "oh-my-posh colorscheme already enabled in $RCFILE"
else
    # If the line doesn't exist, append it to the end of the shell rc file
    echo "$line_to_append" >> "$RCFILE"
    echo "oh-my-posh colorscheme enabled in $RCFILE"
fi
