#!/usr/bin/sh

# Toggles the current default input source on and off
pactl set-source-mute $(pactl get-default-source) toggle
