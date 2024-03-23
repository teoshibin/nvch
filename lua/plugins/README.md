
# Plugins

## TODOs

- keybind map on plugin attach
- fix `<leader>sh` `:Telescope help` overwritten by Nvchad

- git
  - octo (PR)

- editing
  - <https://neovimcraft.com/plugin/folke/zen-mode.nvim>

- file
  - nvim-lsp-file-opreations (for refactoring filenames and imports)

- misc
  - mini.nvim
  - dressing.nvim (make select options to use telescope)
  - beauwilliams/focus.nvim
  - noice

## Nvhcad UI Plugins

```txt
Nvchad/base46                       color theme
Nvchad/ui                           nvchad UI
Nvchad/nvim-colorizer.lua           color code colorizer
nvim-tree/nvim-web-devicons         icons
lukas-reineke/indent-blankline.nvim indentation line     ./editing.lua
nvim-tree/nvim-tree.lua             file tree            ./ui.lua
folke/which-key.nvim                keybind pop up
```

## Nvchad Editing Plugins

```txt
nvim-lua/plenary.nvim           coroutine library
stevearc/conform.nvim           formatter                ./language.lua
nvim-treesitter/nvim-treesitter syntax tree parser       ./language.lua
lewis6991/gitsigns.nvim         git glyph                ./git.lua
williamboman/mason.nvim         server installer         ./language.lua
neovim/nvim-lspconfig           server configuration     ./language.lua
hrsh7th/nvim-cmp                completion engine        ./language.lua
windwp/nvim-autopairs           autopair
saadparwaiz1/cmp_luasnip        snippet engine
hrsh7th/cmp-nvim-lua            completion
hrsh7th/cmp-nvim-lsp            completion
hrsh7th/cmp-buffer              completion
hrsh7th/cmp-path                path completion
numToStr/Comment.nvim           commenting
nvim-telescope/telescope.nvim   fuzzy finder             ./ui.lua
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
