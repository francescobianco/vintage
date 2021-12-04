#!/usr/bin/env bash

## Install "vintage" software manager
curl -s binst.tk | sudo bash -s francescobianco/vintage

## Add your nostalgic software
vintage add qbasic

## Run the MAGIC!
vintage run -t qbasic
