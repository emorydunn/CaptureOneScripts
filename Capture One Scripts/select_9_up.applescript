(**
	Created by: Emory Dunn
	Created on: 2022-09-25

	Copyright © 2022 Emory Dunn, All Rights Reserved

	Select the last n number of photos in Capture One.
**)

-- Settings

set theCount to 9

-- Script

tell front document of application "Capture One 22"
	set lastIndex to count of variants
	set firstIndex to (count of variants) - (theCount - 1)
	set variantsToSelect to variants firstIndex thru lastIndex
	deselect it variants (variants whose selected is true)
	select it variants variantsToSelect
end tell
