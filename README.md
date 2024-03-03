# My Config

Update
```
:NvChadUpdate .
```

## Windows Installation

WIP

## Linux Installation

Remove existing stuff
```bash
mv ~/.config/nvim ~/.config/nvim_bak
rm -rf ~/.local/share/nvim
```

Bash
```bash
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
NVCHAD_EXAMPLE_CONFIG=n nvim --headless "+q"
cd ~/.config/nvim/lua/custom
git clone git@github.com:teoshibin/nvch.git .
```

Fish
```fish
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
set -g -x NVCHAD_EXAMPLE_CONFIG n
nvim --headless "+q"
cd ~/.config/nvim/lua/custom
git clone git@github.com:teoshibin/nvch.git .
```

## Misc

This can be used as an example custom config for NvChad. 
Do check the https://github.com/NvChad/nvcommunity

