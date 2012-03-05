
Multi-Language Comment Script for CotEditor
===========================================

AppleScript for CotEditor.

It comment-outs the selection with proper comment delimiters for selected coloring syntax style.
when no text selection exists it inserts only comment delimiters before the cursor.

I recommend you to use this with your favorite key assign :)

covered languages
-------------
default coloring syntax of CotEditor 1.3（Perl, Ruby, PHP etc...）
as well as Apache, XML, HTML5, SVG, SQL,  Markdown, AppleScript, Go, Scheme, gnuplot, ImageJ, R and ReVIEW
(syntax name must be identical)


usage
-------------
Put the script in CotEditor's *Scripts Folder*  (~/Library/Application Support/CotEditor/ScriptMenu/)


description
-------------
- This script comment-outs the selected area of front document.
  when no text selection exists it inserts only comment delimiters before the cursor.

- This script uncomments commented lines
  when more than half of lines in the selection are already comment-outed at the beginning of lines.
  This ratio is customizable.
  This uncomment function works only by line comment.

- This script comment-outs/uncomments whole first line and last line as well
  when more than 1 line are selected.
  This action can be disable.

- This script comment-outs/uncomments always at the line head 
  by languages that allow line comments only at the beginning of lines like Apache and Shell Script

- This script comment-outs with line comment style 
  by languages that have both line and block comment style
  when the selected lines are less than 10 lines.
  This number is customizable.

- It happens nothing by the uncovered syntax mode.
  You can add extra language definitions in the first half of the the script.


customize
-------------
### key assign
You can assign a keyboard shortcut to the CotEditor script.
default assigned key for this script is Command + Shift + C.
See details on CotEditor help.

### customizable values in script
- `minBlockCommentLines`
	minimum number of lines to use block comment on languages that have both line and block comment style
	
	[default] 10 lines
	
- `commentLinesRate`
	proportion of commented lines for switching to the uncomment function
	
	[default] 1/2

- `spacer`
	spaces between selection and comment delimiters
	
	[default] one length space

- `forceWholeLines`
	commentout/uncomment also whole first line and last line when more than 1 line are selected.
	When value is `false`, comment delimiters are inserted just front and behind of the seletion 
	and line head of first line that isn't selected is ignored by uncomment.
	
	[default] true


author
-------------
1024jp

- website: [Wolfrosch](http://wolfrosch.com/)
- twitter: @1024jp / @1024de


licence
-------------
This script by 1024jp is licensed under a [Creative Commons Attribution-NonCommercial 3.0 Unported License](http://creativecommons.org/licenses/by-nc/3.0/).


version history
-------------
- 2012-03-xx v1.1 
	- now comment-outs/uncomments whole first line and last line as well
	  when more than 1 line are selected (custamizable)
	- now comment-outs/uncomments always at the line head 
	  by languages that allow line comments only at the beginning of lines
	  (namely by Apache and Shell Script mode)
	- now toggles to uncomment mode even if number of the selected lines is greater than `minBlockCommentLines`
	
- 2012-03-01 v1.0.1 
	- bug fix
- 2012-02-25 v1.0 
	- released
