#!/bin/bash

status=$(playerctl status 2>/dev/null)

trunc() {
    if [ "${#1}" -le 13 ]; then
        echo "$1"
    else
        printf '%s…%s\n' "${1%%"${1#??????}"}" "${1##"${1%??????}"}"
    fi
}

title="$(playerctl metadata title 2>/dev/null)"

title_no_ytm="${title//\ \-\ YouTube Music/}"

if [[ "x${title_no_ytm}" != "x" ]]; then
	title="${title_no_ytm}"
fi

title=$(trunc "${title}")

if [[ "x${title}" != "x" ]]; then
	title=" $title "
fi

if [[ "$status" == "Playing" ]]; then
    echo '{"text": "  '"$title"'", "class": "playing"}'
elif [[ "$status" == "Paused" ]]; then
    echo '{"text": "  '"$title"'", "class": "paused"}'
else
    echo '{"text": "", "class":""}'
fi
