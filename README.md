
# Neovim Config

Neovim configuration based on nvchad plugin.

## Installation

Windows

```ps1
cd %localappdata%
git clone git@github.com/teoshibin/nvch.git
nv
```

Linux / WSL

```ps1
cd ~/.config
git clone git@github.com/teoshibin/nvch.git
nv
```

## Aliases

In order to preserve instances of neovim configurations.
One for heavy wordload and another for lighweight workload or serve as a backup.

```ps1
function Get-Nvim-Config {
    param(
        [string]$ConfigName,
        [Parameter(ValueFromRemainingArguments=$true)]
        $args
    )
    $env:NVIM_APPNAME = $ConfigName
    nvim $args
    Remove-Item Env:\NVIM_APPNAME
}
function Get-Nvim-Chad { Get-Nvim-Config -ConfigName "nvch" $args  }
New-Alias -Name nv -Value Get-Nvim-Chad -Force -Option AllScope
```

```fish
function nvim_config -a config_name
    set -x NVIM_APPNAME $config_name
    nvim
end

alias nv='nvim_config "nvch"'
```
