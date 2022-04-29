#!/usr/bin/env bash

# Left as a reminder on how to monitor i3 events in bash
#
# This was an experiment to see if I can trigger the switch-worspace script by
# monitoring i3 events so that both changing workspace using the mouse and the
# keyboard would result in the transition
#
# It doesn't work because the workspace has already changed by the time ./switch-workspace.sh
# has run so I can't screenshot the old workspace without switching back to the
# old workspace - screenshotting - switching to the new workspace before sliding
# the screenshot.  This was slow and buggy.

i3-msg -m -t subscribe '["workspace"]' | \
  while read -r line ; do \
    echo $line | \
      jq '.current .num, .old .num | @sh' | \
      xargs ./switch-workspace.sh; \
  done
