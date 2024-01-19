(**
	Created by: Emory Dunn
	Created on: 2020-07-12

	Copyright © 2024 Emory Dunn, All Rights Reserved

	Sorts the current collection by date (ascending) and renames all variants.
**)

(** Settings **)

-- If enabled the counter is set to 1, otherwise the counter is set based on the first variant
set resetCounter to false

(**  Script **)

use AppleScript version "2.5"
use framework "Foundation"
use scripting additions

tell front document of application "Capture One 23"
	--  Sort by date
	set sorting order of current collection to by date
	set sorting reversed of current collection to false
	
	-- Get current collections variants
	set theVariants to every variant of current collection
	log "Renaming " & number of theVariants & " variants"
	
	-- Batch rename
	if resetCounter then
		set counter of batch rename settings to 1
	else
		-- Get the first variant in the collection
		set firstVar to first variant of current collection
		-- Read the last number from the name
		set firstCount to my readCounter(name of firstVar, "\\d+$")
		
		set counter of batch rename settings to firstCount
	end if
	
	batch rename variants theVariants
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
