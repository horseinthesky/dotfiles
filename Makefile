PATH := $(HOME)/.python/bin:$(PATH)

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
	lua \
	poetry \
	pythontools \
	fnm \
	yarn \
	nvim \
	nvimn \
	docker \
	pyenv \

.PHONY: all $(roles)

all: $(roles)

$(roles):
	@bash $(ROLES_DIR)/$@.sh
