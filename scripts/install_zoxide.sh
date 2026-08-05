#!/bin/bash

app_name="zoxide"

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
    brew install zoxide
  else
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  fi
  echo "Installation complete."
fi

line_to_append="eval \"\$(zoxide init $SHELL_NAME)\""
# Check if the line already exists in the shell rc file
if grep -qF "$line_to_append" "$RCFILE"; then
    echo "$app_name already enabled in $RCFILE"
else
    # If the line doesn't exist, append it to the end of the shell rc file
    echo "$line_to_append" >> "$RCFILE"
    echo "$app_name enabled in $RCFILE"
fi
