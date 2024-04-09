# btw.nvim

Show **"I use Neovim (BTW)"** when **open neovim**. That's all you need.

![Screenshot 2024-04-09 at 1 31 36 PM](https://github.com/letieu/btw.nvim/assets/53562817/26881fab-c911-4c8a-ad73-a78ec78a2c0c)

___

> Why bother with **mini.starter**, **vim-startify**, **dashboard-nvim**, or any of those distractions? I know you, my friend. Forget about all that noise – all you truly need is `I use Neovim (BTW)`. Embrace it proudly, and let your ego shine!

## Features
- **Instant Ego Boost**: Get greeted with "I use neovim (BTW)" on launch.
- **I use Neovim (BTW)**: Show your ego to the world.

## Installation

* With **lazy.nvim**
```lua
{
  "letieu/btw.nvim",
  config = function()
    require('btw').setup()
  end,
}
```
* With **packer.nvim**
```lua
use {
  'letieu/btw.nvim',
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
