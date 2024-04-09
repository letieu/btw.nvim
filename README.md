# btw.nvim

Show **I use Neovim (BTW)** when open neovim. That's all you need.

> Why bother with mini.starter, vim-startify, dashboard-nvim, or any of those distractions? I know you, my friend. Forget about all that noise – all you truly need is I use Neovim (BTW). Embrace it proudly, and let your ego shine!

## Features
- **Instant Ego Boost**: Get greeted with "I use neovim (BTW)" on launch.
- **I use Neovim (BTW)**: Show your ego to the world.

## Installation

* With **lazy.nvim**
```lua
{
  "letieu/jot.lua",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('btw').setup()
  end,
}
```
* With **packer.nvim**
```lua
use {
  'letieu/jot.lua',
  requires = {{'nvim-lua/plenary.nvim'}}
}
```

**Important**: don't forget to call `require('btw').setup()` to enable its functionality.

## Configuration

```lua
require('btw').setup({
  text = "I use Neovim (BTW)",
})
```

## Inspiration and Thanks
- [mini.starter](https://github.com/echasnovski/mini.starter) by @echasnovski
