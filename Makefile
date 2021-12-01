#!make

BIN ?= vintage
PREFIX ?= /usr/local
VINTAGE_CONF := /etc/vintage.conf

USER := $(shell logname)
HOME := $(shell getent passwd $(shell logname) | cut -d: -f6)

install: install-packages install-vintage-files
	@echo Installation complete.

install-packages:
	@apt-get install -y --no-install-recommends xterm > /dev/null

install-vintage-files:
	@touch $(VINTAGE_CONF)
	@cp -f pad $(PREFIX)/bin/$(BIN)
	@chmod +x $(PREFIX)/bin/$(BIN)

uninstall:
	@rm -f $(PREFIX)/bin/$(BIN)

## =====
## Tests
## =====
test-install:
	@sudo make -s install

test-qbasic: test-install
	@vintage install qbasic
	@vintage run qbasic
  
