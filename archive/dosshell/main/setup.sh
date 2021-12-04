#!/bin/bash

vintage --task download dosshell https://archive.org/download/msdos_dosshell/dosshell.zip
vintage --task extract dosshell main
vintage --task copy dosshell/main DOSSHELL
vintage --task shim DOSSHELL "dosshell.exe"
vintage --task alias dosshell DOSSHELL
