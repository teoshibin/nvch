
# Neovim Config

Neovim configuration based on nvchad plugin.

## Plugin Details

See [details](./lua/plugins/README.md)

## Installation

Windows

```ps1
cd %localappdata%
git clone git@github.com/teoshibin/nvch.git
nv
```

Unix shell

```sh
cd ~/.config
git clone git@github.com/teoshibin/nvch.git
nv
```

## Terminals

Add the following remap for Windows terminal for `<C-BS>`

```json
{
    "keys": "ctrl+backspace",
    "command": {
        "action": "sendInput",
        "input": "\u0017"
    }
},
```

## Aliases

Windows powershell

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

Unix fish

```fish
function nvim_config -a config_name
    set -x NVIM_APPNAME $config_name
    nvim
end

alias nv='nvim_config "nvch"'
```
