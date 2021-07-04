SCRIPTS_DIR = scripts

targets = \
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

.PHONY: all $(targets)

all: $(targets)

$(targets):
	@bash $(SCRIPTS_DIR)/$@.sh
