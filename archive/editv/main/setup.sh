#!/bin/bash

vintage --task download editv https://ferguson.home.xs4all.nl/freeware/editv41u.zip
vintage --task extract editv main
vintage --task copy editv/main EDITV
vintage --task shim EDITV "editv.exe"
vintage --task alias editv EDITV
