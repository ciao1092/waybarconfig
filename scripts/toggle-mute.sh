#!/bin/bash

SINK="@DEFAULT_AUDIO_SINK@"
SOURCE="@DEFAULT_AUDIO_SOURCE@"

mic_status=$(wpctl get-volume "$SOURCE" | grep -q "MUTED" && echo "[off]" || echo "[on]")
master_status=$(wpctl get-volume "$SINK" | grep -q "MUTED" && echo "[off]" || echo "[on]")

if [[ "$mic_status" == "[on]" ]]; then
    wpctl set-mute "$SINK" 1        # Mute the Master
    wpctl set-mute "$SOURCE" toggle # Toggle the mic

elif [[ "$master_status" == "[on]" ]]; then
    wpctl set-mute "$SINK" 1        # Mute the Master

else
    wpctl set-mute "$SINK" toggle   # Toggle the Master
    wpctl set-mute "$SOURCE" toggle # Toggle the mic
fi
