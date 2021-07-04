<h1 align="center">dotfiles</h1>
<div align="center">Always a WIP :)</div>

<div align="center">
	<a href="https://github.com/horseinthesky/dotfiles/#features">Features</a>
  <span> • </span>
	<a href="https://github.com/horseinthesky/dotfiles/#install">Install</a>
</div>

## Features

- Autohotkey config for Windows 10/11
- Git config
- Zsh plugins and config
- fzf
- Tmux & tmuxp
- ranger file manager
- cargo package manager
- cli tools (`rg`, `fd`, `lsd`, `procs`, `bat`, `btm`, `tldr`, `du`, `z`, `delta`)
- `asn` llokup tool and traceroute server
- golang
- go tools (`efm-langserver`, `glow`, `duf`)
- lua
- `poetry` Python virtual environment manager
- Python tools (`flake8`, `yapf`, `black`, `mypy`, `autopepe8`, `ptpython`, `httpie`, `isort`, `jedi-langiage-server`)
- `fnm` node manager
- TS tools (`prettier`, `vscode-json-languageserver`, `yaml-language-server`, `lua-fmt`)
- Neovim plugins and configs
- Docker
- `pyenv` Python version manager

## Install

Make sure you have the newest version of Neovim (0.5).

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
