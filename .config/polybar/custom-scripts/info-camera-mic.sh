#!/bin/bash

camera=""
mic=""

if lsof /dev/video0 >/dev/null 2>&1; then
    camera="CAM"
fi

if pacmd list-sources 2>/dev/null | grep -q RUNNING; then
    mic="MIC"
fi

output="$(echo "$camera $mic" | xargs)"

[ -n "$output" ] && echo "$output"
