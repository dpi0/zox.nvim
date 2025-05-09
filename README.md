# `zox.nvim`

> Fzf + Zoxide = 💥

Simply switch to a directory using [zoxide](https://github.com/ajeetdsouza/zoxide) right inside of Neovim.

![screenshot](https://github.com/user-attachments/assets/4deee4a4-5a17-4ae9-b46e-742d3bdfca4f)

## Requirements

**These tools must be present on the machine:**

- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [fzf](https://github.com/junegunn/fzf)

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "dpi0/zox.nvim",
  lazy = true, -- Only run when triggered with a keybind
  dependencies = { "ibhagwan/fzf-lua" },
  opts = {
    fzf_opts = {
      prompt = "Zoxide> ",
      winopts = {
        height = 0.5,      -- window height
        width = 0.5,       -- window width
        row = 0.5,         -- center vertically
        col = 0.5,         -- center horizontally
        anchor = 'center', -- anchor point is center
        border = 'rounded',
      },
    },
  },
  keys = {
    {
      "<leader>Z",
      function() require("zox").fuzzy_find_dir() end,
      desc = "Zoxide Fzf",
    },
  },
}
```

## Usage

Press `<leader>Z` to open zoxide with fzf. Type to fuzzy search. Press Enter to select a directory and switch to it.

It could be a nice idea of pre-populate your zoxide database with almost all your directories.

Query your current database

```bash
zoxide query -ls | fzf
```

Then (completely optional) add directories to it. Required [fd](https://github.com/sharkdp/fd)

```bash
fd -t d . "$HOME" \
  --exclude node_modules \
  --exclude go/pkg/mod \
  --exclude .local/share \
  --exclude .local/state \
  --exclude .vscode \
  --exclude .config/Code \
  --exclude .Trash-1000 \
  --exclude .git \
  --exclude .cargo \
  --exclude .rustup \
  --exclude .cache \
  --exclude .mozilla \
  --exclude .npm \
  -x zoxide add
```

To reverse this command simply run the same command but `zoxide remove` this time!

To clear out the database and start from scratch

```bash
trash ~/.local/share/zoxide/db.zo

```

## Configuration

Window options are configured using [fzf-lua winopts](https://github.com/ibhagwan/fzf-lua#customization)

```bash
  fzf_opts = {
    prompt = "Zoxide> ",
    winopts = {
      height = 0.5,
      width = 0.5,
      border = "rounded",
    },
  },
```
