#!/bin/bash

vintage --task download qbasic https://winworldpc.com/download/e280b0c3-8602-c392-c592-7311c3a5c28f/from/c39ac2af-c381-c2bf-1b25-11c3a4e284a2
vintage --task extract qbasic main --file-format 7z
vintage --task mount qbasic main disk01 "Microsoft DOS QBasic 1.0/disk01.img"
vintage --task copy qbasic main disk01 QBASIC
