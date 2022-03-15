SCRIPTS_DIR = scripts

targets = \
	packages \
	wsl \
	desktop \
	git \
	zsh \
	fzf \
	tmux \
	ranger \
	asn \
	rust \
	go \
	lua \
	poetry \
	python \
	js \
	nvim \
	nvimn \
	docker \
	terraform \
	pyenv \

.PHONY: all $(targets)

all: $(targets)

$(targets):
	@bash $(SCRIPTS_DIR)/$@.sh
