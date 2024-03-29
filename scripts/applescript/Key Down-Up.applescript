tell application "TextEdit"
	activate
	make new document
end tell

try
	tell application "System Events"
		tell process "TextEdit"
			set frontmost to true
		end tell
		
		key down option
		keystroke "e"
		delay 1
		key up option
		keystroke "e"
		keystroke return
		
		keystroke "e" using option down
		delay 1
		keystroke "e"
		keystroke return
		
		key down shift
		keystroke "p"
		key up shift
		keystroke return
		
		key down option
		keystroke "p"
		key up option
		keystroke return
		
		key down {shift, option}
		keystroke "p"
		key up {shift, option}
		keystroke return
		
		keystroke "p" using {shift down, option down}
		keystroke return
		
	end tell
on error errMsg
	display dialog "Error: " & errMsg
end try