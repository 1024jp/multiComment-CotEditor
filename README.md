 
Multi Comment Macro v1.1.6 for CotEditor
=======================================

__Since CotEditor itself introduced a comment toggle feature (by me) on ver. 2.0, This repo is no more maintained.__


AppleScripts for CotEditor.

It comment-outs and uncomments selected text intelligently.


### Features

- inserting proper comment delimiters for selected syntax coloring mode
- comment-outing/uncommenting multiple lines
- intelligent comment-out/uncomment toggle
- switching intelligently from line comments to block comments 
  and from comment-outing at the cursor position to at the line head
- loose select mode
- easy to customize
- include also scripts without the intelligent comment-out/uncomment toggle 


### Supported Languages
built-in syntax highlighting languages on CotEditor 1.5.3（Perl, Ruby, PHP etc...）
also Swift, HTML5, SVG, SQL, AppleScript, Go, Scheme, gnuplot, ImageJ Macro, R and ReVIEW
(syntax name must be identical)

You can also add your favorite languages.

Usage
-------------
Execute it from the CotEditor's script menu or using short cut keys.

### Install
Put .applescript files into CotEditor's *Scripts Folder* (~/Library/Application Support/CotEditor/ScriptMenu/)

### Uninstall
Remove .applescript files you added from CotEditor's *Scripts Folder* 


optional macros
-------------
Optional macros make commenting on CotEditor more useful.
The scripts are independent of each other, so you can put only what you need into the ScriptMenu folder.

### Select Lines
This script selects whole of lines in which the cursor or the selection is. It is useful when you combine this with the _Comment_ macro using short cut keys.

### Comment Out and Uncomment
The _Comment Out_ and _Uncomment_ macros do always its action, while the main macro _Comment_ decides intelligently whether it comment-outs the selection or uncomments it.
The other functions are the same.


Description
-------------
- This script comment-outs the selected text on CotEditor
  when no character is selected it inserts only comment delimiters before the cursor.

- This script uncomments commented lines
  when more than 2/3 of lines in the selection are already comment-outed at the beginning of a line.
  This ratio is customizable.

- This script can uncomment block style comment correctly
  only when just one block comment is exactly selected.

- This script comment-outs/uncomments always at the line head 
  by languages that allow line comments to appear only at the beginning of a line
  (namely by Apache and Shell Script mode)

- This script comment-outs with line comment style 
  by languages that have both line and block comment style
  when the selected lines are less than 10 lines.
  This number is customizable.

- _loose select mode_
  By this mode, the script comment-outs/uncomments whole the first line and the last line as well
  even if the text selection starts/ends in the middle of a line.
  This function is disabled by default.

- It happens nothing by unknown syntax coloring modes.

### What this script CAN NOT do
- uncommenting indented comment lines
- uncommenting multiple block comments


Customize
-------------
### Key Assign
You can assign a keyboard shortcut to the CotEditor script.
Default assigned key for this script is Command + Shift + C.
See details on CotEditor help.

### Customizable Values in Script
Comment, Comment Out and Uncomment scripts are independent of each other. 
Remember namely that you should modify each script files.

- `spacer`
	spaces between selection and comment delimiters
	
	[default] one length space

- `minBlockCommentLines`
	minimum number of lines to use block comment on languages that have both line and block comment style
	
	[default] 10 lines

- `looseSelect`
	minimum number of lines to be enable loose select mode (`0` means disable).
	
	[default] 0 (disable)
	
- `commentLinesRate` [only by Comment script]
	proportion of commented lines for switching to the uncomment function
	
	[default] 2/3

### Adding Languages
You can add extra language definitions at `(insert additional syntax here)` point in the script with the following format.

```AppleScript

	else if coloring style is "foo" then	-- language's name
		set beginDelimiter to "" -- begin delimiter of block comment (leave blank if it doesn't exist)
		set endDelimiter to "" -- end delimiter of block comment (leave blank if it doesn't exist)
		set lineDelimiter to "" -- begin delimiter of line comment (leave blank if it doesn't exist)
		set allowMiddleOfLine to true -- whether line comments can start in the middle of a line
```


Credits
-------------
### Author
1024jp

- website: [Wolfrosch](http://wolfrosch.com/)
- github: [1024jp](https://github.com/1024jp)

### Related Pages
- [repository on GitHub](https://github.com/1024jp/multiComment-CotEditor)
- [Multi Comment Macro for CotEditor -Goodies -Works //Wolfrosch](http://wolfrosch.com/works/goodies/coteditor_comment) only in Japanese


License
-------------
The Multi Comment Macro for CotEditor by 1024jp is licensed under a [Creative Commons Attribution-NonCommercial 3.0 Unported License](http://creativecommons.org/licenses/by-nc/3.0/).

