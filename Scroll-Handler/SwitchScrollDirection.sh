#!/usr/bin/env bash

set -e

if [[ ! "${@}" ]];then
    echo "ERROR: No scroll direction was given."
    exit -1
fi

if [[ "${1}" != "Natural" ]]
then
	direction="Standard"
else
	direction="Natural"
fi

osascript - "${direction}" >/dev/null << EOT
	on run argv
		set direction to item 1 of argv
		tell application "System Preferences"
			reveal anchor "trackpadTab" of pane id "com.apple.preference.trackpad"
		end tell

		tell application "System Events" to tell process "System Preferences"
			repeat until exists tab group 1 of window 0
        	end repeat
			set theCheckbox to checkbox 1 of tab group 1 of window 0
			if direction is equal to "Natural" then
				tell theCheckbox
					if not (its value as boolean) then click theCheckbox
				end tell
			else if direction is equal to "Standard"
				tell theCheckbox
					if (its value as boolean) then click theCheckbox
				end tell
			end if
		end tell
	quit application "System Preferences"
	end run
EOT
