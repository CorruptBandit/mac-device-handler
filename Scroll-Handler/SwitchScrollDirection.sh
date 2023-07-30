#!/usr/bin/env bash

set -e

if [[ ! "${@}" ]];
then
    echo "ERROR: No scroll direction was given."
    exit -1
else
	direction="${1}"
fi

osascript - "${direction}" >/dev/null << EOT
	on run argv
`		set direction to item 1 of argv
		tell application "System Settings"
			activate
		end tell
		tell application "System Events" to tell process "System Settings"
			click menu item "Trackpad" of menu "View" of menu bar 1
			click radio button 2 of tab group 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
			set theCheckbox to checkbox "Natural scrolling" of group 1 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
			if direction is equal to "Natural" then
				tell theCheckbox
					if not (its value as boolean) then click theCheckbox
				end tell
			else if direction is equal to "Standard" then
				tell theCheckbox
					if (its value as boolean) then click theCheckbox
				end tell
			end if
		end tell
		quit application "System Settings"`
	end run
EOT
