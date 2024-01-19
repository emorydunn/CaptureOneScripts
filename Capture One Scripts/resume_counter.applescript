(**
	Created by: Emory Dunn
	Created on: 2024-01-18

	Copyright © 2024 Emory Dunn, All Rights Reserved

	Sets the capture counter to continue from the last image in a collection.
**)

(** Settings **)

-- Set to true to sort the collection by date to use the latest counter
set sortCollection to true

use AppleScript version "2.5"
use framework "Foundation"
use scripting additions

(**  Script **)

tell front document of application "Capture One 23"
	
	if sortCollection then
		-- Sort the collection by date ascending
		tell current collection
			set sorting order to by date
			set sorting reversed to false
		end tell
	end if
	
	-- Get the last variant in the collection
	set lastVar to last variant of current collection
	
	-- Read the last number from the name
	set lastCount to my readCounter(name of lastVar, "\\d+$")
	
	-- Set the counter
	set capture counter to lastCount
	
end tell

property |app| : a reference to current application
on readCounter(theText, thePattern)
	set foundationString to |app|'s NSString's stringWithString:theText
	set match to (foundationString's rangeOfString:thePattern options:(|app|'s NSRegularExpressionSearch))
	set mStart to match's location()
	set mEnd to (match's |length|()) + mStart
	
	set match to characters (mStart + 1) thru mEnd of theText as string
	
	return match as integer
end readCounter
