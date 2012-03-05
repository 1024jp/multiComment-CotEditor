(*

	Multi-Language Comment Script for CotEditor


[description]
	add/remove comment delimiters  from selection

[version] 1.1β
[releace] 2012-02-25
[lastmod] 2012-03-05
[author] 1024jp <http://wolfrosch.com/>
[licence] Creative Commons Attribution-NonCommercial 3.0 Unported License

[default key assign]
	Command + Shift + C
	
[covered languages] 
	- default syntax styles on CotEdito 1.3.1
	- Apache, XML, HTML5, SVG, SQL,  Markdown, AppleScript, Go, Scheme, gnuplot, ImageJ, R and ReVIEW
*)



-- __settings___________________________________________________________________

-- minimum number of lines to use block comment on languages that have both inline and block comment style
property minBlockCommentLines : 10

-- proportion of commented lines for switching to the uncomment function
property commentLinesRate : 1 / 2

-- spaces between selection and comment delimiters
property spacer : " "

-- commentout/uncomment also whole first line and last line when more than 1 line are selected
property forceWholeLines : false


-- __mode_settings_______________________________________________________________

-- toggle mode intelligent
property toggleMode : true

-- set mode to uncomment
property uncomment : false


-- __main_______________________________________________________________________

tell application "CotEditor"
	if exists front document then
		tell front document
			
			
			-- __comment_styles__________________________________________________
			
			-- initialize
			set beginComment to "" -- begin delimiters of the block comment
			set endComment to "" -- end delimiters of the block comment
			set lineComment to "" -- begin delimiters of the line comment
			set allowMiddleOfLine to true --　whether line comments are allowed at the middle of lines
			
			if coloring style is in {"XML", "HTML", "HTML5", "SVG", "Markdown"} then
				set beginComment to "<!--"
				set endComment to "-->"
				
			else if coloring style is "CSS" then
				set beginComment to "/*"
				set endComment to "*/"
				
			else if coloring style is in {"C, C++, Objective-C", "Java", "JavaScript", "PHP", "Go"} then
				set lineComment to "//"
				set beginComment to "/*"
				set endComment to "*/"
				
			else if coloring style is in {"Perl", "Python", "gnuplot", "R"} then
				set lineComment to "#"
				
			else if coloring style is "Ruby" then
				set lineComment to "#"
				-- set beginComment to "=begin" --  block comment allows only at the beginning of lines
				-- set endComment to "=end"
				
			else if coloring style is "SQL" then
				set lineComment to "--"
				
			else if coloring style is in {"Shell Script", "Apache"} then
				set lineComment to "#"
				set allowMiddleOfLine to false
				
			else if coloring style is "ImageJ" then
				set lineComment to "//"
				
			else if coloring style is "LaTeX" then
				set lineComment to "%"
				
			else if coloring style is "eRuby" then
				set beginComment to "<%#"
				set endComment to "#>"
				
			else if coloring style is "Haskell" then
				set lineComment to "--"
				set beginComment to "{-"
				set endComment to "-}"
				
			else if coloring style is "AppleScript" then
				set lineComment to "--"
				set beginComment to "(*"
				set endComment to "*)"
				
			else if coloring style is "Scheme" then
				set lineComment to ";"
				
			else if coloring style is "ReVIEW" then
				set lineComment to "#@"
				
			else
				return
			end if
			
			
			
			
			-- __body_______________________________________________________________
			
			set {locLength, selectionLength} to range of selection
			set {locLines, selectionLines} to line range of selection
			
			-- intelligent line select
			if not allowMiddleOfLine or (forceWholeLines and selectionLines > 1) then
				-- select also whole first and last lines even if selection starts/ends at the middle of a line
				set line range of selection to {locLines, selectionLines}
				set {locLength, selectionLength} to range of selection
				set range of selection to {locLength, selectionLength - 1}
			end if
			
			if (selectionLength > 0) then set theSelection to contents of selection
			
			-- intelligent commentout/uncomment toggle
			if toggleMode then
				set uncomment to false
				
				if (selectionLength > 0) and (lineComment is not "") then
					-- count comment lines
					set escapedLineComment to do shell script "perl -e \"print quotemeta(" & quoted form of lineComment & ")\""
					try
						set commentLines to (do shell script "echo " & quoted form of theSelection & " | grep -c -G '^" & escapedLineComment & "' ") as number
					on error
						set commentLines to 0
					end try
					
					-- toggle to uncomment mode
					if commentLines > commentLinesRate * selectionLines then
						set uncomment to true
					end if
				end if
			end if
			
			
			if ((lineComment is "") or (beginComment is not "" and selectionLines is greater than or equal to minBlockCommentLines)) and not uncomment then -- block comment
				
				set outStr to beginComment & spacer & theSelection & spacer & endComment
				
				if (selectionLength > 0) then -- has selection
					set numOfMove to count of character of outStr
				else -- no selection
					set numOfMove to count of character of (beginComment & spacer)
				end if
				
				
				
				
			else -- line comment
				
				if (selectionLength > 0) then -- has selection
					
					-- split
					set selectionList to paragraphs of theSelection
					
					
					-- add/remove comment delimiters
					repeat with i from 1 to count of selectionList
						set lineStr to item i of selectionList
						
						if uncomment then -- remove comment delimiters
							if lineStr is lineComment or lineStr is (lineComment & spacer) then
								set lineStr to ""
							else if lineStr starts with lineComment & spacer then
								set lineStr to text ((count of (lineComment & spacer)) + 1) thru -1 of lineStr as text
							else if lineStr starts with lineComment then
								set lineStr to text ((count of lineComment) + 1) thru -1 of lineStr as text
							end if
							
						else -- add comment delimiters
							if lineStr is not "" then
								set lineStr to lineComment & spacer & lineStr
							end if
						end if
						
						set item i of selectionList to lineStr
					end repeat
					
					-- join
					set text item delimiters of AppleScript to return
					set outStr to selectionList as text
					
					
				else -- no selection
					set outStr to lineComment & spacer
				end if
				
				set numOfMove to count of character of outStr
			end if
			
			
			-- insert text into document
			set contents of selection to outStr
			set range of selection to {locLength + numOfMove, 0}
			
		end tell
	end if
end tell