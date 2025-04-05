#!/bin/bash

mic_status=$(amixer get Capture | grep -oP '\[on\]|\[off\]' | head -n 1)

master_status=$(amixer get Master | grep -oP '\[on\]|\[off\]' | head -n 1)

if [[ "$mic_status" == "[on]" ]]; then
    amixer set Master mute        # Mute the Master
    amixer set Capture toggle     # Toggle the mic (mute or unmute)
elif [[ "$master_status" == "[on]" ]]; then
    amixer set Master mute        # Mute the Master
else
    amixer set Master toggle      # Toggle the Master
    amixer set Capture toggle     # Toggle the mic
fi
