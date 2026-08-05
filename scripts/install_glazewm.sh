#!/bin/bash

OS="$(uname)"

if [[ "$OS" != "Darwin" ]]; then
  echo "GlazeWM/zebar only support macOS and Windows, skipping on $OS."
  exit 0
fi

# Check if GlazeWM is installed
if brew list --cask glazewm >/dev/null 2>&1; then
  echo "GlazeWM is already installed."
else
  echo "GlazeWM is not installed. Installing..."
  brew install --cask glzr-io/tap/glazewm
  echo "Installation complete."
fi

# Check if zebar is installed
if brew list --cask zebar >/dev/null 2>&1; then
  echo "zebar is already installed."
else
  echo "zebar is not installed. Installing..."
  brew install --cask glzr-io/tap/zebar
  echo "Installation complete."
fi

# GlazeWM/zebar config directory
ln -s `pwd`/configs/.glzr/ $HOME/.glzr
