#!/usr/bin/env bash

#ghostplay silent
ghostplay_custom_prompt() { # change prompt
  printf '$ '
}
#ghostplay end

## Install "vintage" software manager
##
curl -s binst.tk | sudo bash -s francescobianco/vintage
#ghostplay silent
sleep 3
#ghostplay end

##
## Add your nostalgic software
##
vintage add qbasic
#ghostplay silent
sleep 3
#ghostplay end

##
## Run the MAGIC!
##
vintage run -t qbasic
#ghostplay silent
sleep 3
#ghostplay end
