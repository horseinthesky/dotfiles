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
	cli \
	asn \
	go \
	gotools \

.PHONY: all $(roles)

all: $(roles)

$(roles):
	@bash $(ROLES_DIR)/$@.sh
