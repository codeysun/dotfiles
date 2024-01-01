#!/bin/bash
# First, install the nvim appimage

# Nvim config file
rm -rf $HOME/.config/nvim/
ln -s `pwd`/configs/nvim/ $HOME/.config/nvim/
