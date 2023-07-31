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
		set settings_pane to "Trackpad"
		tell application "System Settings"
			activate
		end tell
		tell application "System Events"
			tell application process "System Settings"
				tell splitter group 1 of group 1 of window 1
					repeat until outline 1 of scroll area 1 of group 1 exists
						delay 0
					end repeat
					tell outline 1 of scroll area 1 of group 1
						set row_names to value of static text of UI element 1 of every row
						repeat with i from 1 to (count row_names)
							if settings_pane is not "Apple ID" then
								if item i of row_names = {settings_pane} then
									select row i
									exit repeat
								end if
							else
								try
									if item 1 of item i of row_names contains settings_pane then
										select row i
										exit repeat
									end if
								end try
							end if
						end repeat
					end tell
				end tell
			end tell
		end tell
		tell application "System Events" to tell process "System Settings"
			repeat while not (exists radio button 2 of tab group 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1)
				delay 0
			end repeat
			click radio button 2 of tab group 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
			set theCheckbox to checkbox "Natural scrolling" of group 1 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window 1
			repeat while not (exists theCheckbox)
				delay 0
			end repeat
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
