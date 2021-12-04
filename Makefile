#!make

BIN ?= vintage
PREFIX ?= /usr/local
VINTAGE_CONF := /etc/vintage.conf

USER := $(shell logname)
HOME := $(shell getent passwd $(shell logname) | cut -d: -f6)

install: install-dependencies install-vintage-files
	@echo Installation complete.

install-dependencies:
	@apt-get install -y --no-install-recommends xterm curl p7zip-full > /dev/null
	@curl -sLo $(PREFIX)/bin/getoptions https://github.com/ko1nksm/getoptions/releases/latest/download/getoptions
	@chmod +x $(PREFIX)/bin/getoptions

install-vintage-files:
	@touch $(VINTAGE_CONF)
	@cp -f vintage $(PREFIX)/bin/$(BIN)
	@chmod +x $(PREFIX)/bin/$(BIN)

uninstall:
	@rm -f $(PREFIX)/bin/$(BIN)

demo:
	@curl -sL git.io/ghostplay | bash -s contrib/demo.sh

## =====
## Tests
## =====
test-install:
	@sudo make -s install

test-install-vintage-files:
	@sudo make -s install-vintage-files

test-version:
	@sudo make -s install-vintage-files
	@bash vintage -s version vintage
	@bash vintage -s version vintage --resolve 2

test-add-missing:
	@sudo make -s install-vintage-files
	@bash vintage add missing || true
	@bash vintage add missing@missing || true

test-add: test-install-vintage-files
	@bash vintage add dosshell

test-download-qbasic: test-install-vintage-files
	@bash vintage -t download qbasic https://winworldpc.com/download/e280b0c3-8602-c392-c592-7311c3a5c28f/from/c39ac2af-c381-c2bf-1b25-11c3a4e284a2

test-extract-qbasic: test-download-qbasic
	@bash vintage -t extract qbasic main --file-format 7z

test-mount-qbasic: test-extract-qbasic
	@bash vintage -t mount qbasic main disk01 "Microsoft DOS QBasic 1.0/disk01.img"

test-copy-qbasic: test-mount-qbasic
	@bash vintage -t copy qbasic main disk01 QBASIC

test-exec: test-install-vintage-files
	@bash vintage --task exec https://raw.githubusercontent.com/francescobianco/vintage/main/archive/fritz/main/setup.sh

test-run: test-install-vintage-files
	@vintage run fritz
