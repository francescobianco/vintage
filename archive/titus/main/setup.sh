#!/bin/bash

vintage --task download titus https://tagz.eu/dl/61aab9ac52ce2-titusthefox
vintage --task extract titus main
vintage --task copy titus/main TITUS
vintage --task shim TITUS "call RUNME.BAT"
vintage --task alias titus TITUS
