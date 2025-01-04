#!/bin/bash

app_name="zoxide"

# Check if app is installed
if which "$app_name" >/dev/null; then
  echo "$app_name is already installed."
else
  # If the application is not found, install it
  echo "$app_name is not installed. Installing..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  echo "Installation complete."
fi

line_to_append="eval \"\$(zoxide init bash)\""
# Check if the line already exists in .bashrc
if grep -qF "$line_to_append" ~/.bashrc; then
    echo "$app_name already enabled in ~/.bashrc"
else
    # If the line doesn't exist, append it to the end of .bashrc
    echo "$line_to_append" >> ~/.bashrc
    echo "$app_name enabled in ~/.bashrc"
fi
