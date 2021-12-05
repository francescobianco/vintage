#!/usr/bin/env bash

#ghostplay silent
ghostplay_custom_prompt() { # change prompt
  printf '$ '
}
ghostplay_before_prompt_hook() {
  :
}
ghostplay_after_prompt_hook() {
  ghostplay_sleep 1
}
#ghostplay end

# Install "Vintage" Software Manager
#
curl -s binst.tk | sudo bash -s francescobianco/vintage
#ghostplay silent
sleep 3
#ghostplay end

#
# Add Your Nostalgic Software
#
#ghostplay silent
sleep 2
#ghostplay end
vintage add qbasic
#ghostplay silent
sleep 4
#ghostplay end

#
# Run the MAGIC!
#
# just type:  vintage run qbasic
#
#ghostplay silent
sleep 3
#ghostplay end
vintage run -t qbasic
#ghostplay silent
sleep 3
#ghostplay end
