use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

tell front document of application "Capture One 12"
	--  Sort by date
	set sorting order of current collection to by date
	set sorting reversed of current collection to false
	
	-- Get current collections variants
	set theVariants to every variant of current collection
	log "Renaming " & number of theVariants & " variants"
	
	-- Batch rename
	set counter of batch rename settings to 1
	batch rename variants theVariants
end tell
