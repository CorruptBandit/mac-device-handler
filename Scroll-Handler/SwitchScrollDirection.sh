#!/usr/bin/env bash

set -e

if [[ ! "${@}" ]];
then
    echo "ERROR: No scroll direction was given."
    exit -1
else
	direction=$(if [ "${1}" == "Natural" ]; then echo true; else echo false; fi)
fi

defaults write -g com.apple.swipescrolldirection -bool "${direction}"

# Refresh Settings without Logout & Login
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
