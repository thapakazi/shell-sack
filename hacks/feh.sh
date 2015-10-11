#!/bin/bash

# I moved /usr/local/bin/feh -> feh.old
#this script will override the moved feh with config :D

feh.org --scale-down --auto-zoom --geometry 800x640 "$@"
