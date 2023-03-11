<h1 align="center">🛠️ dotfiles</h1>
<div align="center">Always a WIP :)</div>

<div align="center">
    <a href="https://github.com/horseinthesky/dotfiles/#%EF%B8%8F-requirements">Requirements</a>
  <span> • </span>
	<a href="https://github.com/horseinthesky/dotfiles/#-features">Features</a>
  <span> • </span>
	<a href="https://github.com/horseinthesky/dotfiles/#-installation">Installation</a>
</div>

## 📚 Screenshots

This is how Neovim start screen looks like

![aplha](https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/alpha.png)

Neovim experience

![nvim](https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/nvim.png)
![nvim_insert](https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/nvim_insert.png)

Neovim telescope plugin for findig stuff

![telescope](https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/telescope.png)

Shell FZF tool

![fzf](https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/fzf.png)

Shell `ripgrep` tool

![rg](https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/rg.png)

Shell `fd` tool

![fd](https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/fd.png)

## ⚡️ Requirements

- Regular Linux host. **Debian** and **Arch** based distros are supported
- Git
- [Nerd Font](https://www.nerdfonts.com/) **_(optional)_**

## ✨ Features

Here is a list of what is going to be installed and setup:

- [Autohotkey](https://www.autohotkey.com/) ultimate automation scripting language for Windows
- `.gitconfig` (change email and username to yours in `scripts/git.sh`)
- Zsh, its config, aliases, custom functions and plugins:
  - [zsh-completions](https://github.com/zsh-users/zsh-completions)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [alias-tips](https://github.com/djui/alias-tips)
  - [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme consructor
- [fzf](https://github.com/junegunn/fzf) and a bunch of functions for:
  - Git fuzzy functions (see `files/zsh/fzf-git-functions.zsh`)
  - `apt` and `pacman` fuzzy functions and many more (see `files/zsh/fzf-functions.zsh`)
- [Tmux](https://github.com/tmux/tmux) terminal multiplexer & its session manager [tmuxp](https://github.com/tmux-python/tmuxp)
- [asn](https://github.com/nitefood/asn) lookup tool and traceroute server
- [Terraform](https://www.terraform.io/) with [terraform-ls](https://github.com/hashicorp/terraform-ls) language server
- [Docker](https://www.docker.com/) comunity edition container runtime
- [Neovim](https://neovim.io/) with a ton of plugins (Lua based configuration). You can find old VimScript version (with CoC) in [this repo](https://github.com/horseinthesky/vimscript)
- [Rust](https://www.rust-lang.org/):
  - [cargo](https://crates.io/) package manager
  - Tools (`ripgrep`, `fd-find`, `zoxide`, `exa`, `xh`, `btm`, `tldr`, `delta`, etc.)
  - [Rust analyzer](https://rust-analyzer.github.io/) language server
- [Golang](https://go.dev/):
  - Tools (`glow`, `duf`)
  - [gopls](https://github.com/golang/tools/tree/master/gopls) language server
- [Lua](https://www.lua.org/)
- [Python](https://www.python.org/):
  - A better Python REPL [ptpython](https://github.com/prompt-toolkit/ptpython)
  - Linters, formatters and static type checkers (`flake8`, `isort`, `black`, `mypy` and `ruff`)
  - [python-lsp-server](https://github.com/python-lsp/python-lsp-server)
  - [pyenv](https://github.com/pyenv/pyenv) Python version manager
  - [poetry](https://python-poetry.org/) Python virtual environments manager
- [fnm](https://github.com/Schniz/fnm). Language servers:
  - [prettierd](https://github.com/fsouza/prettierd)
  - [vscode-langservers-extracted](https://github.com/hrsh7th/vscode-langservers-extracted)
  - [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)
  - [dockerfile-language-server-nodejs](https://github.com/rcjsuen/dockerfile-language-server-nodejs)

## 📦 Installation

### Clone the repo

```
git clone https://github.com/horseinthesky/dotfiles
```

### Install bootstrap packages

```
cd dotfiles && ./bootstrap.sh
```

### Use `make` to install whatever tool you need

```
make zsh nvim
```

or all of them at once

```
make
```
