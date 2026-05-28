#!/bin/bash

SINK="@DEFAULT_AUDIO_SINK@"
SOURCE="@DEFAULT_AUDIO_SOURCE@"

sink_mute=$(wpctl get-volume "$SINK" | grep -o "MUTED")
source_mute=$(wpctl get-volume "$SOURCE" | grep -o "MUTED")

# Toggle microphone first (independent of output state)
if [[ "$source_mute" == "MUTED" ]]; then
    wpctl set-mute "$SOURCE" 0
else
    wpctl set-mute "$SOURCE" 1
fi

# Then toggle audio output
if [[ "$sink_mute" == "MUTED" ]]; then
    wpctl set-mute "$SINK" 0
else
    wpctl set-mute "$SINK" 1
fi
