#!/bin/bash

#awesome text-particles by awesome dude
URL='http://william.hoza.us/text/?t='

INPUT=${@:-"$0 your text please"}

xdg-open "$URL$INPUT"
