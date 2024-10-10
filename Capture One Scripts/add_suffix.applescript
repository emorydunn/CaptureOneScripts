(**
	Created by: Emory Dunn
	Created on: 2020-07-12

	Copyright © 2024 Emory Dunn, All Rights Reserved

	Appends the specified suffix to variants. 
	
	Variants which already have the suffix, if any, will not be renamed. 
	If all variants have the suffix the suffix will be removed.
	By default only selected variants are renamed. 
**)

(** Settings **)

-- The default suffix
set theSuffix to "_Plate"

-- Ask for a suffix to be entered
set prompt to true

-- Save the suffix that was entered
set rememberPreviousSuffix to true

-- Only add the suffix to selected variants
set selectedOnly to true

(**  Script **)

if prompt then
	log "Asking for new suffix"
	if rememberPreviousSuffix then
		log "Attempting to read previous suffix from user defaults"
		try
			set RenameSuffix to do shell script "defaults read com.captureone.captureone16 RenameSuffix"
		on error
			log "Failed to read previous suffix"
			set RenameSuffix to theSuffix
		end try
	else
		set RenameSuffix to theSuffix
	end if
	
	try
		set theResponse to display dialog ¬
			"Add suffix to images" default answer ¬
			RenameSuffix buttons {"Cancel", "Continue"} ¬
			default button ¬
			"Continue" cancel button "Cancel"
		
		set theSuffix to text returned of theResponse
		
	on error
		return
	end try
	
	try
		do shell script "defaults write com.captureone.captureone16 RenameSuffix " & theSuffix
	on error
		log "Failed to save suffix"
	end try
end if

use application "Capture One"
tell current document
	
	-- Figure out which images need renaming
	if selectedOnly then
		--set theVariants to every variant whose selected is true
		set needsSuffix to (every variant whose selected is true and name does not end with theSuffix)
	else
		--set theVariants to every variant
		set needsSuffix to (every variant whose name does not end with theSuffix)
	end if
	
	if (count of needsSuffix) is 0 then
		log "No images requrie renaming"
		
		if selectedOnly then
			set hasSuffix to (every variant whose selected is true and name ends with theSuffix)
		else
			set hasSuffix to (every variant whose name ends with theSuffix)
		end if
		
		my removeSuffix(theSuffix, hasSuffix)
	else
		log "Renaming " & (count of needsSuffix) & " variants"
		my appendSuffix(theSuffix, needsSuffix)
	end if
	
end tell

on appendSuffix(theSuffix, theVariants)
	tell current document
		-- Save the current settings
		set oldFormat to token format of batch rename settings
		
		set method of batch rename settings to text and tokens
		
		-- Set the new format
		set token format of batch rename settings to "[Image Name]" & theSuffix
		
		log "Renaming " & (count of theVariants) & " variants"
		batch rename variants theVariants
		
		-- Restore the token format
		set token format of batch rename settings to oldFormat
	end tell
end appendSuffix

on removeSuffix(theSuffix, theVariants)
	tell current document
		
		set method of batch rename settings to find and replace
		
		set oldFind to find text of batch rename settings
		set oldReplace to replacement text of batch rename settings
		
		set find text of batch rename settings to theSuffix
		set replacement text of batch rename settings to ""
		
		log "Renaming " & (count of theVariants) & " variants"
		batch rename variants theVariants
		
		set find text of batch rename settings to oldFind
		set replacement text of batch rename settings to oldReplace
	end tell
end removeSuffix
