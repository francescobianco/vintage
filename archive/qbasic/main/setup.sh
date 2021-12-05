#!/bin/bash

vintage --task download qbasic https://archive.org/download/GorillasQbasic/gorillas_qbasic.zip
#vintage --task extract qbasic main --file-format 7z
vintage --task extract qbasic main
#vintage --task mount qbasic/main disk01 "Microsoft DOS QBasic 1.0/disk01.img"
#vintage --task copy qbasic/main/disk01 QBASIC
vintage --task copy qbasic/main QBASIC
vintage --task shim QBASIC "qbasic.exe"
vintage --task alias qbasic QBASIC
