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

test-add-qbasic:
	@sudo make -s install-vintage-files
	@bash vintage add qbasic edit

test-download-qbasic: test-install-vintage-files
	@bash vintage download qbasic https://winworldpc.com/download/e280b0c3-8602-c392-c592-7311c3a5c28f/from/c39ac2af-c381-c2bf-1b25-11c3a4e284a2

test-extract-qbasic: test-download-qbasic
	@bash vintage extract qbasic main --file-format 7z

test-mount-qbasic: test-extract-qbasic
	@bash vintage mount qbasic main disk01 "Microsoft DOS QBasic 1.0/disk01.img"

test-copy-qbasic: test-mount-qbasic
	@bash vintage copy qbasic main disk01 QBASIC

test-qbasic: test-install
	@vintage run qbasic edit

