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
		set direction to item 1 of argv
		do shell script "open x-apple.systempreferences:com.apple.Trackpad-Settings.extension"
		tell application "System Events" to tell process "System Settings"
			repeat while not (exists radio button 2 of tab group 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1)
				delay 0
			end repeat
			repeat while not (exists checkbox "Natural scrolling" of group 1 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1)
				click radio button 3 of tab group 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
				click radio button 2 of tab group 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
			end repeat
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
		quit application "System Settings"
	end run
EOT
