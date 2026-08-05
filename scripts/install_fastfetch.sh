#!/bin/bash

app_name="fastfetch"

OS="$(uname)"
if [[ "$OS" == "Darwin" ]]; then
  RCFILE="$HOME/.zshrc"
else
  RCFILE="$HOME/.bashrc"
fi

# Check if app is installed
if which "$app_name" >/dev/null; then
  echo "$app_name is already installed."
else
  # If the application is not found, install it
  echo "$app_name is not installed. Installing..."
  if [[ "$OS" == "Darwin" ]]; then
    brew install fastfetch
  else
    sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
    sudo apt install fastfetch
  fi
  echo "Installation complete."
fi

ln -s `pwd`/configs/fastfetch/ $HOME/.config/

line_to_append="fastfetch"
# Check if the line already exists in the shell rc file
if grep -qF "$line_to_append" "$RCFILE"; then
    echo "$app_name already enabled in $RCFILE"
else
    # If the line doesn't exist, append it to the end of the shell rc file
    echo "$line_to_append" >> "$RCFILE"
    echo "$app_name enabled in $RCFILE"
fi
