#!/bin/bash
sleep 0.3
export DISPLAY=:0.0
scrot -s ~/.screenshot.png && xclip -selection clipboard -t image/png ~/.screenshot.png
