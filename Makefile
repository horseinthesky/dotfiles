SCRIPTS_DIR = scripts

targets = \
	packages \
	wsl \
	desktop \
	git \
	zsh \
	fzf \
	tmux \
	asn \
	rust \
	go \
	lua \
	pyenv \
	python \
	js \
	nvim \
	docker \
	cloud \

.PHONY: all $(targets)

all: $(targets)

$(targets):
	@bash $(SCRIPTS_DIR)/$@.sh
