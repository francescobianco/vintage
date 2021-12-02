#!make

BIN ?= vintage
PREFIX ?= /usr/local
VINTAGE_CONF := /etc/vintage.conf

USER := $(shell logname)
HOME := $(shell getent passwd $(shell logname) | cut -d: -f6)

install: install-dependencies install-vintage-files
	@echo Installation complete.

install-dependencies:
	@apt-get install -y --no-install-recommends xterm curl > /dev/null
	@curl -sLo $(PREFIX)/bin/getoptions https://github.com/ko1nksm/getoptions/releases/latest/download/getoptions
	@chmod +x $(PREFIX)/bin/getoptions

install-vintage-files:
	@touch $(VINTAGE_CONF)
	@cp -f vintage $(PREFIX)/bin/$(BIN)
	@chmod +x $(PREFIX)/bin/$(BIN)

uninstall:
	@rm -f $(PREFIX)/bin/$(BIN)

## =====
## Tests
## =====
test-install:
	@sudo make -s install

test-add-qbasic:
	@sudo make -s install-vintage-files
	@bash vintage add qbasic edit

test-qbasic: test-install
	@vintage run qbasic edit

