(**
	Created by: Emory Dunn
	Created on: 2023-09-27

	Copyright © 2023 Emory Dunn, All Rights Reserved

	Flip the crop orientation of variants. 
	
	This script (should) follow whether Edit All Selected Variants is enabled.

**)
use application "Capture One"

tell application "System Events"
	
	set imageMenu to menu bar item "Image" of menu bar 1 of application process "Capture One"
	set editAllItem to menu item "Edit All Selected Variants" of menu 1 of imageMenu
	
	-- Use the accessibility attribute to determine the state of the menu
	set checked to value of attribute "AXMenuItemMarkChar" of editAllItem
	
end tell

if checked is equal to missing value then
	log "Editing primary variant"
	
	set oldSize to crop size of primary variant
	set newSize to {item 2 of oldSize, item 1 of oldSize}
	
	set crop size of primary variant to newSize
	
else
	log "Editing all selected variants"
	
	repeat with theVariant in (variants whose selected is true)
		set oldSize to crop size of theVariant
		set newSize to {item 2 of oldSize, item 1 of oldSize}
		
		set crop size of theVariant to newSize
	end repeat
	
end if
