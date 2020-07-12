(*
	Apply keywords from the clipboard to all variants in the current collection.

	Each line of text in the clipboard is applied as a separate keyword. The keywords
	are added to the whatever the current keywords are.

	If you need to remove all keywords, use "Reset Keywords", which will remove all
	keywords from every variant in the current collection.

	Created by Emory Dunn

*)

use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

set theRawKeywords to the clipboard as string

set dialogAnswer to display dialog ¬
	"Apply " & number of paragraphs of theRawKeywords & " keywords" buttons {"Reset Keywords", "No", "Yes"} ¬
	default button "Yes"
if button returned of dialogAnswer is "Yes" then
	repeat with theLine in paragraphs of theRawKeywords
		log theLine as string
		setKeyword(theLine)
	end repeat
else if button returned of dialogAnswer is "Reset Keywords" then
	resetKeywords()
end if


on setKeyword(theKeyword)
	tell front document of application "Capture One 12"
		--	Capture One does not allow `,` or `|` in keywords
		set theCleanKeyword to my replace_chars(theKeyword, ",", " ")
		set theCleanKeyword to my replace_chars(theCleanKeyword, "|", " ")

		repeat with theVariant in variants of current collection
			tell theVariant to make keyword with properties {name:theCleanKeyword}

		end repeat

	end tell
end setKeyword

on resetKeywords()
	tell front document of application "Capture One 12"

		delete every keyword of every variant of current collection

	end tell

end resetKeywords

-- From https://www.macosxautomation.com/applescript/sbrt/sbrt-06.html
on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars