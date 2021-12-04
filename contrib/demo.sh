#!/usr/bin/env bash

#ghostplay silent
ghostplay_custom_prompt() { # change prompt
  printf '$ '
}
#ghostplay end

## Install "vintage" software manager
curl -s binst.tk | sudo bash -s francescobianco/vintage

## Add your nostalgic software
vintage add qbasic

## Run the MAGIC!
vintage run -t qbasic
