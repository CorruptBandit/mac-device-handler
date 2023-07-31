#!/usr/bin/env bash

set -e

if [[ ! "${@}" ]];
then
    if [[ -z "${DEVICE_TO_CHECK}" ]];
    then
        echo "ERROR: No device was given."
        exit -1
    else
        DEVICE_TO_CHECK="${DEVICE_TO_CHECK}"
    fi
else
    DEVICE_TO_CHECK="${1}"
fi

get_device_status() {
    if [[ "$(ioreg -p IOUSB | grep -i "${DEVICE_TO_CHECK}")" ]]
    then
        echo "plugged"
    else
        echo "unplugged"
    fi
}

change_settings() {
    if [[ "$(get_device_status)" == "plugged" ]]
    then
        /usr/local/bin/SwitchKeyboard "British-PC"
        /usr/local/bin/SwitchScrollDirection "Standard"
    else
        /usr/local/bin/SwitchKeyboard "British"
        /usr/local/bin/SwitchScrollDirection "Natural"
    fi
}

_prev_status="$(get_device_status)"
change_settings
while true
do
    if [[ "$(get_device_status)" != "${_prev_status}" ]]
    then
        _prev_status="$(get_device_status)"
        change_settings
    fi
    sleep 3
done
