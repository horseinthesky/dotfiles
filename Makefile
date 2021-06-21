export PATH := $(HOME)/opt/venv/bin:$(PATH)
# export DOTFILES_HOME = $(HOME)/dotfiles/files

ROLES_DIR = scripts
roles = packages wsl git zsh

.PHONY: all $(roles)

all: $(roles)

packages:
	@bash $(ROLES_DIR)/packages.sh

wsl:
	@bash $(ROLES_DIR)/wsl.sh

git:
	@bash $(ROLES_DIR)/git.sh

zsh:
	@bash $(ROLES_DIR)/zsh.sh
