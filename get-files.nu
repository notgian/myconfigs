#!/usr/bin/env nu

# assumption that this is run with sudo
cp -r $"($env.HOME)/.config/nvim" ./nvim
cp $"($env.HOME)/.tmux.conf" ./tmux/.tmux.conf
cp $"($env.HOME)/.config/nushell/config.nu" ./nushell/config.nu

