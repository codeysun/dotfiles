# dotfiles

Repository for various system configuration ("dot") files

# Install Guide

Make sure Neovim, tmux, and oh-my-posh are installed

Add the following to `~/.bashrc`:

```
# Neovim
export PATH="~/.local/bin:$PATH"

# oh-my-posh
eval "$(oh-my-posh init bash --config ~/.cache/oh-my-posh/themes/catppuccin.omp.json)"
```

Run the install script: ./install

If you also want to install the splash screen:

```bash
sudo rm -f /etc/motd
sudo ln -s ~/dotfiles/motd /etc/motd
```
