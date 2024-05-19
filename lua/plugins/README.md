
# Plugins

## TODOs

- auto resize ui, beauwilliams/focus.nvim
- godot vim [plugin link](https://github.com/habamax/vim-godot)
- git octo (PR)

## Nvhcad UI Plugins

```txt
Nvchad/base46                       color theme
Nvchad/ui                           nvchad UI
Nvchad/nvim-colorizer.lua           color code colorizer
nvim-tree/nvim-web-devicons         icons
lukas-reineke/indent-blankline.nvim indentation line     ./edit.lua
nvim-tree/nvim-tree.lua             file tree            ./ui.lua
folke/which-key.nvim                keybind pop up
```

## Nvchad Editing Plugins

```txt
nvim-lua/plenary.nvim           coroutine library
stevearc/conform.nvim           formatter                ./lsp.lua
nvim-treesitter/nvim-treesitter syntax tree parser       ./lsp.lua
lewis6991/gitsigns.nvim         git glyph                ./vcs.lua
williamboman/mason.nvim         server installer         ./lsp.lua
neovim/nvim-lspconfig           server configuration     ./lsp.lua
hrsh7th/nvim-cmp                completion engine        ./lsp.lua
windwp/nvim-autopairs           autopair
saadparwaiz1/cmp_luasnip        snippet engine
hrsh7th/cmp-nvim-lua            completion
hrsh7th/cmp-nvim-lsp            completion
hrsh7th/cmp-buffer              completion
hrsh7th/cmp-path                path completion
numToStr/Comment.nvim           commenting
nvim-telescope/telescope.nvim   fuzzy finder             ./ui.lua
```

## Custom Plugins

```txt
kylechui/nvim-surround          surround motion          ./edit.lua
NMAC427/guess-indent.nvim       update indentation       ./edit.lua
folke/todo-comments.nvim        highlight comments       ./edit.lua
max397574/better-escape.nvim    better jj & jk           ./edit.lua
Pocco81/auto-save.nvim          autosave :ASToggle       ./edit.lua

NeogitOrg/neogit                git general              ./vcs.lua
sindrets/diffview.nvim          git diff & merge         ./vcs.lua

folke/trouble.nvim              error quickfix           ./lsp.lua
mfussenegger/nvim-dap           (WIP) debugger           ./lsp.lua
mrcjkb/rustaceanvim             rust lsp bundle          ./rust.lua

antosha417/nvim-lsp-file-operations     workspace rename ./ui.lua   
nvim-treesitter/nvim-treesitter-context sticky scope     ./ui.lua
ThePrimeagen/harpoon                    file bookmark    ./ui.lua
dstein64/nvim-scrollview                scrollbar        ./ui.lua
stevearc/dressing.nvim                  rename select ui ./ui.lua 
folke/zen-mode.nvim                     zen mode         ./ui.lua
kevinhwang91/nvim-bqf                   quickfix preview ./ui.lua

chrishrb/gx.nvim                netrw gx open url        ./misc.lua        
ThePrimeagen/vim-be-good        game :VimBeGood          ./misc.lua
eandrju/cellular-automaton.nvim game :CellularAutomaton  ./misc.lua
nacro90/numb.nvim               peek line :<number>      ./misc.lua
rmagatti/auto-session           (WIP) save session       ./misc.lua 
```

## Configuration

To make a plugin not be loaded

```lua
{
 "NvChad/nvim-colorizer.lua",
 enabled = false
},
```

All NvChad plugins are lazy-loaded by default For a plugin to be loaded, you
will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`.
If you want a plugin to load on startup, add `lazy = false` to a plugin spec,
for example

```lua
{
 "mg979/vim-visual-multi",
 lazy = false,
}
```

Refer to source code of nvchad to see api that shouldn't be overwritten
