#!/bin/bash

# Tmux config file
rm -rf $HOME/.tmux.conf
ln -s `pwd`/configs/tmux.conf $HOME/.tmux.conf
