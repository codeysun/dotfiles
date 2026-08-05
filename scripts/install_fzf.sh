#!/bin/bash

app_name="fzf"

OS="$(uname)"
if [[ "$OS" == "Darwin" ]]; then
  RCFILE="$HOME/.zshrc"
  SHELL_NAME="zsh"
else
  RCFILE="$HOME/.bashrc"
  SHELL_NAME="bash"
fi

# Check if app is installed
if which "$app_name" >/dev/null; then
  echo "$app_name is already installed."
else
  # If the application is not found, install it
  echo "$app_name is not installed. Installing..."
  if [[ "$OS" == "Darwin" ]]; then
    brew install fzf
  else
    url="https://github.com/junegunn/fzf/releases/download/v0.56.3/fzf-0.56.3-linux_amd64.tar.gz"
    install_dir="$HOME/.local/bin"
    mkdir -p "$install_dir"
    app_tar="$install_dir/fzf.tar.gz"
    wget -qO "$app_tar" "$url"
    tar -xvf "$app_tar" -C "$install_dir"
    rm "$app_tar"
  fi
  echo "Installation complete."
fi

line_to_append="eval \"\$(fzf --$SHELL_NAME)\""
# Check if the line already exists in the shell rc file
if grep -qF "$line_to_append" "$RCFILE"; then
    echo "fzf already enabled in $RCFILE"
else
    # If the line doesn't exist, append it to the end of the shell rc file
    echo "$line_to_append" >> "$RCFILE"
    echo "fzf enabled in $RCFILE"
fi
