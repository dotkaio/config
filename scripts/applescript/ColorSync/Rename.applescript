(*
Rename - Use sips to rename a profile, changing its description string.

Copyright © 2009Ð2020 Apple Inc.

You may incorporate this Apple sample code into your program(s) without
restriction.  This Apple sample code has been provided "AS IS" and the
responsibility for its operation is yours.  You are not permitted to
redistribute this Apple sample code as "Apple sample code" after having
made changes.  If you're going to redistribute the code, we require
that you make it clear that the code was descended from Apple sample
code, but that you've made changes.
*)

on run
	display dialog "Change a profile's description string."
	set chosenFile to choose file with prompt "Choose a profile" default location POSIX file "/Library/ColorSync/Profiles"
	open chosenFile
end run


on open draggedItems
	repeat with thisFile in (draggedItems as list)
		try
			tell application "Finder" to set fileName to name of thisFile
			set filePath to quoted form of POSIX path of thisFile
			set cmdLine to ("sips -g allxml " & filePath) as string
			set infoString to do shell script cmdLine
			
			-- to check if the file is a color profile, check for existence of "pcs" field containing profile connection space
			if xmlvalue(infoString, "pcs") is not equal to "" then
				set descriptionString to xmlvalue(infoString, "description")
				set theButton to button returned of (display dialog "filename: " & fileName & return & "description: " & descriptionString & return & return & "Change description string to match the filename?" buttons {"no", "other...", "filename"} default button 3)
				if theButton is "other..." then
					set newName to text returned of (display dialog "Enter new profile description string" default answer descriptionString)
					set cmdLine to ("sips -s description '" & newName & "' " & filePath) as string
					do shell script cmdLine
				else if theButton is "filename" then
					set newName to fileName
					set cmdLine to ("sips -s description '" & newName & "' " & filePath) as string
					do shell script cmdLine
				end if
			end if
			
		end try
	end repeat
end open


-- this assumes one level deep
on xmlvalue(theString, theItem)
	try
		tell application "System Events"
			set newPlistItem to make new property list item with data theString
			return value of property list item theItem of newPlistItem
		end tell
	on error
		return ""
	end try
end xmlvalue

