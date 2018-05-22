(*
	Apply keywords to all variants in the current collection.

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
	tell front document of application "Capture One 11"

		repeat with theVariant in variants of current collection
			tell theVariant to make keyword with properties {name:theKeyword}

		end repeat

	end tell
end setKeyword

on resetKeywords()
	tell front document of application "Capture One 11"

		delete every keyword of every variant of current collection

	end tell

end resetKeywords