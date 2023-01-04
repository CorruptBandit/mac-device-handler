#!/usr/bin/env bash

set -e

if [[ ! "${@}" ]]; then
    echo "ERROR: No device was given."
    exit -1
fi

DEVICE_TO_CHECK="${1}"
_tmp="$(ioreg -p IOUSB)"

change_settings() {
    if [[ "$(ioreg -p IOUSB)" == *"${DEVICE_TO_CHECK}"* ]]
        then
            /usr/local/bin/SwitchKeyboard "British-PC"
            /usr/local/bin/SwitchScrollDirection "Standard"
        else
            /usr/local/bin/SwitchKeyboard "British"
            /usr/local/bin/SwitchScrollDirection "Natural"
        fi
            _tmp="$(ioreg -p IOUSB)"
}

change_settings
while true
do
    if [[ "$(ioreg -p IOUSB)" != "${_tmp}" ]]
    then 
        change_settings
    fi
	sleep 3
done
