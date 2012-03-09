(*

	Select Whole Current Lines


[description]
	select whole of lines in which the cursor or the selection is

[version] 1.0
[release] 2012-03-08
[author] 1024jp <http://wolfrosch.com/>
[licence] public domain

[default key assign]
	Command + Shift + A
*)

tell application "CotEditor"
	if exists front document then
		tell front document
			set line range of selection to line range of selection
		end tell
	end if
end tell