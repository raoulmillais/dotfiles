#!/usr/bin/env bash

# This script should be invoked by i3 when switching workspaces.  It is a
# hacky way to provide a slide effect transition from one workspace to
# the next.
#
# It uses scrot to take a screenshot and then uses feh to display the image
# and wmctrl to slide the image across the screen.
#
# Currently this works by binding $mod+<num> in i3's config which means the
# transition only runs when using the keyboard and not clicking the worspace
# on the titlebar
#
# TODO: This script can occasionally glitch if hammering the $+num keys.  Be
# more defensive and detect if a transition is in progress and do the right
# thing.
#
# Usage:
#   switch-workspace.sh 2

# Note the screen resolutions are hardcoded for my machine.  You should adjust
# these for your own preferences.

set -euo pipefail

workspace=$1
current_workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true) | .num')
display_width=3840
display_height=2160
image_quality=50
gravity=1

if [ $current_workspace -ne $workspace ]; then
  image_name=$(mktemp -u --suffix=.jpg)
  # screenshot the current workspace before switching
  scrot -q $image_quality $image_name
  # show the screenshot
  feh $image_name &
  feh_pid=$!
  # Wait a moment for the window to appear
  sleep .1
  # remember the window id of feh so that we can "slide" it later
  feh_id=`wmctrl -l | grep "$image_name$" | awk '{print $1}'`
  # Make feh a sticky floating window that covers the whole screen and then
  # switch to the new workspace and restore focus to feh
  i3-msg -q "[instance=feh] floating enable, sticky enable, border pixel 0, move absolute position 0 px 0 px; workspace number $workspace"
fi

slide_right() {
  local max=0
  let max=display_width+40
  for (( step=0; step!=$max; step=step+20 )) do
    wmctrl -i -r $feh_id -e $gravity,$step,0,$display_width,$display_height
  done
  sleep .1
  kill $feh_pid
}

slide_left() {
  local max=0
  let max=-display_width+40
  for (( step=0; step!=$max; step=step-20 )) do
    wmctrl -i -r $feh_id -e $gravity,$step,0,$display_width,$display_height
  done
  kill $feh_pid
}

if [ $current_workspace -gt $workspace ]; then
  slide_right
else
  slide_left
fi
