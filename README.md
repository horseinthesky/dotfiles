<h1 align="center">dotfiles</h1>
<div align="center">Always a WIP :)</div>

<div align="center">
	<a href="https://github.com/horseinthesky/dotfiles/#features">Features</a>
  <span> • </span>
	<a href="https://github.com/horseinthesky/dotfiles/#install">Install</a>
</div>

<img src ="https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/alpha.png"><hr>
<img src ="https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/nvim.png"><hr>
<img src ="https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/nvim_insert.png"><hr>
<img src ="https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/telescope.png"><hr>
<img src ="https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/fzf.png"><hr>
<img src ="https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/rg.png"><hr>
<img src ="https://raw.githubusercontent.com/horseinthesky/dotfiles/master/media/fd.png"><hr>

## Features

- Autohotkey config for Windows 10/11
- Git config
- Zsh config and plugins:
  - [zsh-completions](https://github.com/zsh-users/zsh-completions)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [alias-tips](https://github.com/djui/alias-tips)
  - [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [fzf](https://github.com/junegunn/fzf) and a bunch of functions for:
  - Git (see `files/zsh/fzf-git-functions.zsh`)
  - `apt` and `pacman` plugin managers and more (see `files/zsh/fzf-functions.zsh`)
- Tmux & tmuxp
- [asn](https://github.com/nitefood/asn) lookup tool and traceroute server
- [Terraform](https://www.terraform.io/) and `terrafrom-ls`
- [Docker](https://www.docker.com/) and `docker-ls`
- [Neovim](https://neovim.io/) (Lua based configuration). You can find old VimScript version (with CoC) in [this repo](https://github.com/horseinthesky/vimscript)
- [Rust](https://www.rust-lang.org/):
  - [cargo](https://crates.io/) package manager
  - Tools (`ripgrep`, `fd-find`, `zoxide`, `exa`, `xh`, `btm`, `tldr`, `delta`, etc.)
  - [Rust analyzer](https://rust-analyzer.github.io/)
- [Golang](https://go.dev/):
  - Tools (`glow`, `duf`)
  - [gopls](https://github.com/golang/tools/tree/master/gopls) language server
- [Lua](https://www.lua.org/):
- [Python](https://www.python.org/):
  - Tools (`ptpython`, `httpie`)
  - Linters, formatters and static type checkers (`flake8`, `isort`, `black`, `mypy`)
  - [jedi-langiage-server](https://github.com/pappasam/jedi-language-server)
  - [pyenv](https://github.com/pyenv/pyenv) Python version manager
  - [poetry](https://python-poetry.org/) Python virtual environment manager
- [fnm](https://github.com/Schniz/fnm). Installs language servers:
  - [prettierd](https://github.com/fsouza/prettierd)
  - [vscode-langservers-extracted](https://github.com/hrsh7th/vscode-langservers-extracted)
  - [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)
  - [dockerfile-language-server-nodejs](https://github.com/rcjsuen/dockerfile-language-server-nodejs)

## Install

Make sure you have the newest version of Neovim (0.7).

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
