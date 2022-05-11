#!/usr/bin/bash

# REQUIRES COMMAND `pactl` (PULSEAUDIO RELATED)



# Get available sinks and active default sink + the amount of sinks
sink_list=($(pactl list sinks short | awk '{print $2}'))
sink_num=$(pactl list sinks short | wc -l)
sink_current=$(pactl info | grep -e "Default Sink" | awk '{print $3}')


# Get index of current default sink
for i in "${!sink_list[@]}";
do
    if [[ "${sink_list[$i]}" = "$sink_current" ]]
    then
        index="$i"
    fi
done


# Decrement sink_num by 1 (zero-indexed)
((sink_num="$sink_num"-1))

# Increment index or set to 0 if index==sink_num ("overflow" back to 0)
if [[ "$index" = "$sink_num" ]]
then
    index=0
else
    ((index="$index"+1))
fi

# Set default sink to the next available in array
pactl set-default-sink "${sink_list[$index]}"
