#!/bin/bash

## WinWorld Download
#vintage --task download qbasic https://winworldpc.com/download/c5a11f1d-c386-c592-7311-c3a5c28f1352/from/c39ac2af-c381-c2bf-1b25-11c3a4e284a2
#vintage --task extract qbasic main --file-format 7z
#vintage --task mount qbasic/main disk01 "Microsoft DOS QBasic 1.1/disk01.img"
#vintage --task copy qbasic/main/disk01 QBASIC
#vintage --task shim QBASIC "qbasic.exe"
#vintage --task alias qbasic QBASIC

## Alternative Download
vintage --task download qbasic https://hwiegman.home.xs4all.nl/downloads/qbasic11.zip
vintage --task extract qbasic main
vintage --task copy qbasic/main QBASIC
vintage --task shim QBASIC "qbasic.exe"
vintage --task alias qbasic QBASIC
