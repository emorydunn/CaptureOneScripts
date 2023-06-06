(**
	Created by: Emory Dunn
	Created on: 2023-06-05

	Copyright © 2023 Emory Dunn, All Rights Reserved

	Save the current aspect ratio in the IPTC Content Description.

	**Important Notes**

	This script gets the name of the currently selected aspect ratio in the
	crop tool, it does _not_ read the aspect ratio of the variant.
	As such there are some limitations to what it can do.

	By default this script only applies metadata to the primary variant
	because the crop ratio is more likely to match the selected ratio.

	When `applyToAllVariants` it's important to make sure all selected
	variants actually cropped to the desired ratio.

**)

(* Settings *)

-- Update the metadata of all selected variants, not just the primary variant.
set applyToAllVariants to false

(* Script *)

tell application "System Events"
	-- Read the aspect ratios file. This may need to change with future C1 releases
	tell property list file "~/Library/Application Support/Capture One/Aspect Ratios 8.2/User Aspect Ratios.xml"

		-- Get the selected ratio
		-- This will either be the UUID of a user ratio or the name of a standard ratio
		-- Unconstrained, Original, and Output all end in ID
		set selectedRatioName to value of property list item "SelectedAspectRatioUID"

		set AspectRatios to property list item "AspectRatios"

		-- Attempt to find the name of the matching UUID
		repeat with ratio in property list item of AspectRatios
			if (value of first property list item of ratio whose name is "Uid") is equal to selectedRatioName then
				set selectedRatioName to (value of first property list item of ratio whose name is "Name")
			end if
		end repeat

	end tell

end tell

tell application "Capture One 23"

	-- We're just going to ignore ratios without names
	if selectedRatioName ends with "ID" then
		if applyToAllVariants then
			set content description of every variant whose selected is true to ""
		else
			set content description of primary variant to ""
		end if
	else
		if applyToAllVariants then
			set content description of every variant whose selected is true to selectedRatioName
		else
			set content description of primary variant to selectedRatioName
		end if
	end if

end tell
