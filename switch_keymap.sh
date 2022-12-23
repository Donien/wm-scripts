#!/usr/bin/sh

# Switches beteween three keyboard settings (two german, one english): de, de nodeadkeys, us

current_layout="$(setxkbmap -query | grep layout | awk '{ print $2 }')"
current_variant="$(setxkbmap -query | grep variant | awk '{ print $2 }')"

if [[ "$current_layout" == "de" && "$current_variant" == "" ]]; then
    setxkbmap de nodeadkeys

elif [[ "$current_layout" == "de" && "$current_variant" == "nodeadkeys" ]]; then
    setxkbmap us

else
    setxkbmap de
fi
