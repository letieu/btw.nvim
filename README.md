# btw.nvim

Show **"I use Neovim (BTW)"** when **open neovim**. That's all you need.

<img width="1336" alt="Screenshot 2024-04-10 at 11 32 10 PM" src="https://github.com/letieu/btw.nvim/assets/53562817/f61b39e2-46fc-4d1c-b0f8-8a0a04d42b1f">

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
