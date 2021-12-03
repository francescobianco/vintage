#!/bin/bash

vintage --task download fritz http://www.retrogames.cz/dos/fritz2.zip
vintage --task extract fritz main
vintage --task mount fritz main disc "fritz2.img" --image-format ntfs
vintage --task copy fritz main disc FRITZ
