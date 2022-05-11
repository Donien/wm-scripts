#!/usr/bin/bash

# REQUIRES COMMAND `pactl` (PULSEAUDIO RELATED)



# Get available sources and active default source + the amount of sources
# Also exclude monitors
source_list=($(pactl list sources short | grep -v '.monitor' | awk '{print $2}'))
source_num=$(pactl list sources short | grep -v '.monitor' | wc -l)
source_current=$(pactl info | grep -e 'Default Source' | awk '{print $3}')


# Get index of current default source
for i in "${!source_list[@]}";
do
    if [[ "${source_list[$i]}" = "$source_current" ]]
    then
        index="$i"
    fi
done


# Decrement source_num by 1 (zero-indexed)
((source_num="$source_num"-1))

# Increment index or set to 0 if index==source_num ("overflow" back to 0)
if [[ "$index" = "$source_num" ]]
then
    index=0
else
    ((index="$index"+1))
fi

# Set default source to the next available in array
pactl set-default-source "${source_list[$index]}"
