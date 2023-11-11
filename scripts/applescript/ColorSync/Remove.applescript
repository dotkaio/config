(*
Remove - Use sips to remove embedded profile and color management data from an image.

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
	display dialog "Remove the embedded profile from an image."
	set chosenFile to choose file with prompt "Choose an image " default location path to desktop folder
	open chosenFile
end run


on open draggedItems
	repeat with thisFile in (draggedItems as list)
		try
			-- use 'sips -d profile' to remove an embedded profile
			-- or use 'sips -d profile --deleteColorManagementProperties' to remove an embedded profile and other color related info
			set filePath to quoted form of POSIX path of thisFile
			set cmdLine to ("sips -d profile --deleteColorManagementProperties " & filePath) as string
			do shell script cmdLine
		end try
	end repeat
end open
