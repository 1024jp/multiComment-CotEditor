(*

Multi-Language Comment Script for CotEditor


[description]
add/remove comment delimiters from selection

[version] 1.0.1
[lastmod] 2012-03-01
[release] 2012-02-25
[author] 1024jp (http://wolfrosch.com/)
[licence] Creative Commons Attribution-NonCommercial 3.0 Unported License

[default key assign]
	Command + Shift + c
	
[covered languages] 
	- default syntax styles on CotEdito 1.3.1
	- Apache, XML, HTML5, SVG, SQL,  Markdown, AppleScript, Go, Scheme, gnuplot, ImageJ, R and ReVIEW
*)



-- __setting_______________________________________________________________

-- minimum number of lines to use block comment on languages that have both inline and block comment style
property minBlockCommentLines : 10

-- proportion of comment lines for switching the uncomment function
property commentLinesRate : 1 / 2

-- spaces between selection and comment delimiters
property spacer : " "



-- __comment_styles_______________________________________________________________


tell application "CotEditor"
	if exists front document then
		
		-- set comment delimiters by syntax mode
		tell front document
			-- initialize
			set beginComment to "" -- begin delimiters of the block comment
			set endComment to "" -- end delimiters of the block comment
			set lineComment to "" -- begin delimiters of the line comment
			set middleOfLine to true -- line comment at the middle of a line (has no function yet)
			
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
				
			else if coloring style is in {"Perl", "Python", "gnuplot"} then
				set lineComment to "#"
				
			else if coloring style is "Ruby" then
				set lineComment to "#"
				-- set beginComment to "=begin" --  block comment allows only at the beginning of a line
				-- set endComment to "=end"
				
			else if coloring style is "SQL" then
				set lineComment to "--"
				
			else if coloring style is in {"Shell Script", "Apache"} then
				set lineComment to "#"
				set middleOfLine to false
				
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
		end tell
		
		
		
		
		-- __body_______________________________________________________________
		
		set {locLength, selectionLength} to range of selection
		set {locLines, selectionLines} to line range of selection
		
		
		
		if (lineComment is "") or (beginComment is not "" and selectionLines is greater than or equal minBlockCommentLines) then -- block comment
			
			set outStr to beginComment & spacer & contents of selection & spacer & endComment
			
			if (selectionLength > 0) then -- has selection
				set numOfMove to count of character of outStr
			else -- no selection
				set numOfMove to count of character of (beginComment & spacer)
			end if
			
			
			
			
		else -- line comment
			if (selectionLength > 0) then -- has selection
				
				-- split
				set selectionList to paragraphs of contents of selection
				
				-- count comment lines in selection
				set commentLines to 0
				repeat with lineStr in selectionList
					if lineStr starts with lineComment then
						set commentLines to commentLines + 1
					end if
				end repeat
				
				-- add/remove comment delimiters
				repeat with i from 1 to count of selectionList
					set lineStr to item i of selectionList
					
					--chomp
					--if lineStr is "\n" then
					--	set lineStr to ""
					--else if lineStr ends with "\n" then
					--	set lineStr to text 1 thru -2 of lineStr as text
					--end if
					
					if commentLines > commentLinesRate * selectionLines then -- uncomment
						if lineStr is lineComment or lineStr is (lineComment & spacer) then
							set lineStr to ""
						else if lineStr starts with lineComment & spacer then
							set lineStr to text ((count of (lineComment & spacer)) + 1) thru -1 of lineStr as text
						else if lineStr starts with lineComment then
							set lineStr to text ((count of lineComment) + 1) thru -1 of lineStr as text
						end if
						
					else -- commentout
						if lineStr is not "" then
							set lineStr to lineComment & spacer & lineStr
						end if
					end if
					
					set item i of selectionList to lineStr
				end repeat
				
				-- join
				--set text item delimiters of AppleScript to return
				set text item delimiters of AppleScript to ""
				set outStr to selectionList as text
				
				
			else -- no selection
				set outStr to lineComment & spacer
			end if
			
			set numOfMove to count of character of outStr
		end if
		
		
		-- echo
		set contents of selection to outStr
		set range of selection to {locLength + numOfMove, 0}
		
	end if
end tell