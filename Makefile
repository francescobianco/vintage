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

## =======
## Contrib
## =======
install-contrib:
	@apt-get install -y --no-install-recommends xterm curl p7zip-full dh-autoreconf > /dev/null

demo:
	#@date > contrib/demo.ts
	#@git add . && git commit -am "Start Recording" && git push
	@asciinema rec --overwrite -c "curl -sL git.io/ghostplay | bash -s contrib/demo.sh" contrib/demo.cast
	@sed -e 's/"width": [0-9]*,/"width": 80,/' \
		 -e 's/"height": [0-9]*,/"height": 25,/' \
		 -e 's/\[sudo\] password for .*:/[sudo\] password for user:/' \
		 -i contrib/demo.cast
	@docker run --rm -v $$PWD:/data:rw asciinema/asciicast2gif -w 80 -h 25 -s 2 -t solarized-dark contrib/demo.cast contrib/demo.gif
	@sudo chmod 777 -R contrib

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
	@bash vintage add qbasic

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
	@vintage --task run -t qbasic

test-shell: test-install-vintage-files
	@vintage --task shell -t
