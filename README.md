
Multi-Language Comment Script for CotEditor
===========================================

AppleScript for CotEditor.

It comment-outs and uncomments selected text intelligent.


features
-------------
- inserting proper comment delimiters for selected coloring syntax style
- multiple lines comment-out/uncomment
- intelligent comment-out/uncomment toggle
- switching intelligent from line comments to block comments 
  and from comment-outing at the cursor position to at the line head
- easy to customize
- include also scripts without the intelligent comment-out/uncomment toggle 


Supported Languages
-------------

default coloring syntax of CotEditor 1.3（Perl, Ruby, PHP etc...）
as well as Apache, XML, HTML5, SVG, SQL,  Markdown, AppleScript, Go, Scheme, gnuplot, ImageJ, R and ReVIEW
(syntax name must be identical)

You can also add your favorite languages.



Usage
-------------
Execute it from the CotEditor's script menu or using short cut keys (Command + Shift + C).

### Install
Put .scpt files into CotEditor's *Scripts Folder* (~/Library/Application Support/CotEditor/ScriptMenu/)

### Uninstall
Remove .scpt files you added from CotEditor's *Scripts Folder* 



Difference between Comment, Comment Out and Uncomment scripts
-------------
The main script _Comment_ decides intelligent whether it comment-outs the selection or uncomments it.
Otherwise, The _Comment Out_ and _Uncomment_ scripts do always its action. The other functions are the same as _Comment_ script.

The scripts are independent of each other, so you can put only what you need into the ScriptMenu folder.


Description
-------------
- This script comment-outs the selected text on CotEditor
  when no character is selected it inserts only comment delimiters before the cursor.

- This script uncomments commented lines
  when more than half of lines in the selection are already comment-outed at the beginning of lines.
  This ratio is customizable.
  This uncomment function works only by line comments.

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

### What this script CAN NOT do
- uncommenting indented comment lines
- uncommenting block comments


Customize
-------------
### key assign
You can assign a keyboard shortcut to the CotEditor script.
Default assigned key for this script is Command + Shift + C.
See details on CotEditor help.

### customizable values in script
Comment, Comment Out and Uncomment scripts are independent of each other. 
Remember namely that you should modify each script files.

- `minBlockCommentLines`
	minimum number of lines to use block comment on languages that have both line and block comment style
	
	[default] 10 lines
	
- `commentLinesRate`
	proportion of commented lines for switching to the uncomment function
	
	[default] 1/2

- `spacer`
	spaces between selection and comment delimiters
	
	[default] one length space

- `looseSelect`
	comment-out/uncomment also whole first line and last line when more than 1 line are selected.
	When value is `false`, comment delimiters are inserted just front and behind of the selection 
	and line head of first line that isn't selected is ignored by uncomment.
	
	[default] false

### adding languages
You can add extra language definitions in the first half of the script.


Credits
-------------
- [repository on GitHub](https://github.com/1024jp/CommentScript-for-CotEditor)
- [CotEditor用スクリプト -Goodies -Works //ヴォルフロッシュ](http://wolfrosch.com/works/goodies/coteditor_scripts#comment) only in Japanese

### Author
1024jp

- website: [Wolfrosch](http://wolfrosch.com/)
- twitter: @1024jp / @1024de
- github: [1024jp](https://github.com/1024jp)

Licence
-------------
This script by 1024jp is licensed under a [Creative Commons Attribution-NonCommercial 3.0 Unported License](http://creativecommons.org/licenses/by-nc/3.0/).

