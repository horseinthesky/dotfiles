PATH := $(HOME)/opt/venv/bin:$(PATH)
# DOTFILES_HOME = $(HOME)/dotfiles/files

ROLES_DIR = scripts

roles = \
	packages \
	wsl \
	git \
	zsh \
	fzf \
	tmux \
	ranger \
	cargo \
	rg \

.PHONY: all $(roles)

all: $(roles)

$(roles):
	@bash $(ROLES_DIR)/$@.sh
