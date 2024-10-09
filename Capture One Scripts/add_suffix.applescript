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

set theSuffix to "_Bowl"

set selectedOnly to true

(**  Script **)
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
