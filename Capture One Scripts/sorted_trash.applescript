--
--	Created by: Emory Dunn
--	Created on: 4/11/23
--
--	Copyright © 2023 Lost Cause Photographic, All Rights Reserved
--
-- Keep your images organized by folder even in the trash. 
--

use application "Capture One 22"

on run
	
	if kind of current collection of current document is favorite then
		fastTrash()
	else
		slowTrash()
	end if
	
end run

-- When working with a single favorite trash all variants at once
on fastTrash()
	
	log "Running fast trash"
	
	-- Get the selected variants and session Trash folder
	set theVariants to variants whose selected is true
	set sessionTrashFolder to trash of current document
	
	-- Get the name of the collection
	set dirName to name of current collection of current document
	
	-- Create a folder
	tell application "Finder"
		try
			set trashFolder to (make new folder at sessionTrashFolder with properties {name:dirName}) as alias
		on error
			set trashFolder to (folder named dirName of folder sessionTrashFolder) as alias
		end try
	end tell
	
	-- Add to faves
	-- Add the new folder as a favorite		
	tell current document
		set trashCol to make collection with properties {kind:favorite, file:trashFolder}
		
		
	end tell
	
	-- Trash the variant
	move inside trashCol variants theVariants
	
	-- Clean up trash
	delete trashCol
	
end fastTrash


-- Iterate through selected variants
-- 
-- Creates a folder, adds a favorite, and moves the variant. One variant at a time.
on slowTrash()
	
	log "Running slow trash"
	
	-- Get the selected variants and session Trash folder
	set theVariants to variants whose selected is true
	set sessionTrashFolder to trash of current document
	
	-- Create a list of rubbish favorites
	set trashCollections to {}
	
	repeat with theVariant in theVariants
		
		-- Get the name of the folder for each image
		set theFile to file of parent image of theVariant as alias
		tell application "Finder"
			-- Create a matching directory in the Trash
			set dirName to name of container of theFile
			
			try
				set trashFolder to (make new folder at sessionTrashFolder with properties {name:dirName}) as alias
			on error
				set trashFolder to (folder named dirName of folder sessionTrashFolder) as alias
			end try
		end tell
		
		-- Add the new folder as a favorite		
		tell current document
			set trashCol to make collection with properties {kind:favorite, file:trashFolder}
			
			copy trashCol to end of trashCollections
			
		end tell
		
		-- Trash the variant
		move inside trashCol variants {theVariant}
		
	end repeat
	
	-- Clean up trash
	repeat with col in trashCollections
		if col exists then
			delete col
		end if
	end repeat
end slowTrash
