#!/bin/bash

vintage --task download fritz http://www.retrogames.cz/dos/fritz2.zip
vintage --task extract fritz main
vintage --task mount fritz main disk "fritz2.img" --image-type vfat --image-offset 4096
vintage --task copy fritz main disk FRITZ
vintage --task entrypoint FRITZ "fritz.exe"
