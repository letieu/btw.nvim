# btw.nvim

Show **"I use Neovim (BTW)"** when **open neovim**. That's all you need.

<img width="1470" alt="Screenshot 2024-04-09 at 8 21 57 PM" src="https://github.com/letieu/btw.nvim/assets/53562817/0a5f9627-a1ed-4cf5-82c2-c4211f2a860b">

___

> Why bother with **mini.starter**, **vim-startify**, **dashboard-nvim**, or any of those distractions? I know you, my friend. Forget about all that noise – all you truly need is `I use Neovim (BTW)`. Embrace it proudly, and let your ego shine!
>
> *-- ChatGPT*

## Features
- **Instant Ego Boost**: Get greeted with "I use neovim (BTW)" on launch.

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
- **[mini.starter](https://github.com/echasnovski/mini.starter)** by @echasnovski for code
- **Github Copilot** for code
- **ChatGPT** for `README.md` file
