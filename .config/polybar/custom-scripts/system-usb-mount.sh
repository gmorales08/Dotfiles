#!/bin/sh

devices=$(lsblk -Jplno NAME,TYPE,RM,SIZE,MOUNTPOINT,VENDOR)

case "$1" in
    --mount)
        for mount in $(echo "$devices" | jq -r '.blockdevices[]  | select(.type == "part") | select(.rm) | select(.mountpoint == null) | .name'); do
          output=$(udisksctl mount --no-user-interaction -b "$mount")
          #mountpoint=$(echo "$output" | awk -F' at ' '{print $2}' | tr -d '.')

          #[ -n "$mountpoint" ] && nemo "$mountpoint" &
        done
        ;;
    --unmount)
        for unmount in $(echo "$devices" | jq -r '.blockdevices[]  | select(.type == "part") | select(.rm) | select(.mountpoint != null) | .name'); do
            udisksctl unmount --no-user-interaction -b "$unmount"
            udisksctl power-off --no-user-interaction -b "$unmount"
        done
        ;;
    --open-in-explorer)
        for mounted in $(echo "$devices" | jq -r '.blockdevices[]  | select(.type == "part") | select(.rm) | select(.mountpoint != null) | .name'); do
          mountpoint=$(findmnt -no TARGET "$mounted")
          [ -n "$mountpoint" ] && nemo "$mountpoint" &
        done
        ;;
    *)
        output=""
        counter=0

        for unmounted in $(echo "$devices" | jq -r '.blockdevices[]  | select(.type == "part") | select(.rm) | select(.mountpoint == null) | .name'); do
            unmounted=$(echo "$unmounted" | tr -d "[:digit:]")
            unmounted=$(echo "$devices" | jq -r '.blockdevices[]  | select(.name == "'"$unmounted"'") | .vendor')
            unmounted=$(echo "$unmounted" | tr -d ' ')

            if [ $counter -eq 0 ]; then
                space=""
            else
                space="   "
            fi
            counter=$((counter + 1))

            output="$output$space$unmounted"
        done

        for mounted in $(echo "$devices" | jq -r '.blockdevices[] | select(.type == "part") | select(.rm) | select(.mountpoint != null) | .size'); do
            if [ $counter -eq 0 ]; then
                space=""
            else
                space="   "
            fi
            counter=$((counter + 1))

            output="$output$space$mounted"
        done

        echo "$output"
        ;;
esac
