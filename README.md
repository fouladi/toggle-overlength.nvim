# toggle-overlength.nvim

A Neovim plugin to toggle the highlithing of text exceeding the
column length.

# Installation

Install the plugin with your package manager:

[lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "fouladi/ccrypt-wrapper.nvim",
    config = function()
        require("toggle-overlength").setup({})
    end,
}
```
