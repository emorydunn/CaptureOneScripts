(**
	Created by: Emory Dunn
	Created on: 2024-01-31

	Copyright © 2024 Emory Dunn, All Rights Reserved

	Crop the primary variant to the overlay.

**)

tell application "Capture One"
	
	(* Get the dimensions of the image *)
	set imageDimensions to dimensions of parent image of primary variant
	set imageWidth to item 1 of imageDimensions
	set imageHeight to item 2 of imageDimensions
	
	(* Get overlay info *)
	tell current document
		set imagePath to image path of overlay settings
		
		(* Offset the origin by 50 points *)
		set hPos to (horizontal position of overlay settings) + 50
		set vPos to (vertical position of overlay settings) + 50
		set oScale to (scale of overlay settings) / 100
		
		-- Can't crop outside of the image
		if oScale is greater than 1 then
			set result to display alert "Can't crop outside of image bounds." message "The overlay scale must be 100 or less." as critical buttons ["Cancel", "Adjust Scale"] default button "Adjust Scale"
			
			if button returned of result is equal to "Adjust Scale" then
				set scale of overlay settings to 100
				set oScale to 1
			else
				return
			end if
			
		end if
		
	end tell
end tell

(* Read the overlay image properties *)
tell application "Image Events"
	try
		set overlayImage to open imagePath
		
		set overlayDimensions to dimensions of overlayImage
		set overlayWidth to item 1 of overlayDimensions
		set overlayHeight to item 2 of overlayDimensions
		set overlayRatio to overlayWidth / overlayHeight
		
		close overlayImage
	on error
		tell current application
			display alert "Could not read the overlay file." message "The script failed to read the dimensions of the file." as critical
			return
		end tell
	end try
end tell

(* Calculate the crop size *)
if overlayRatio is greater than 1 then
	set cropWidth to overlayWidth * (imageWidth * oScale / overlayWidth) as integer
	set cropHeight to cropWidth * 1 / overlayRatio as integer
else
	set cropHeight to overlayHeight * (imageHeight * oScale / overlayHeight) as integer
	set cropWidth to cropHeight * overlayRatio as integer
end if

(* Calculate the crop center *)
set xPos to imageWidth * (hPos / 100) as integer
set yPos to imageHeight * (vPos / 100) as integer

log "Crop Width: " & cropWidth
log "Crop Height: " & cropHeight
log "Crop X: " & xPos
log "Crop Y: " & yPos

(* Check that the new crop is horizontally in bounds of the image*)
if xPos + (cropWidth / 2) is greater than imageWidth then
	display alert "Can't crop outside of image bounds." message "The overlay extends past the right edge of the image." as critical buttons ["OK"] default button "OK"
	return
else if xPos - (cropWidth / 2) is less than 0 then
	display alert "Can't crop outside of image bounds." message "The overlay extends past the left edge of the image." as critical buttons ["OK"] default button "OK"
	return
end if

(* Check that the new crop is vertically in bounds of the image*)
if yPos + (cropHeight / 2) is greater than imageHeight then
	display alert "Can't crop outside of image bounds." message "The overlay extends past the bottom edge of the image." as critical buttons ["OK"] default button "OK"
	return
else if yPos - (cropHeight / 2) is less than 0 then
	display alert "Can't crop outside of image bounds." message "The overlay extends past the top edge of the image." as critical buttons ["OK"] default button "OK"
	return
end if

(* Finally apply the crop *)
tell application "Capture One"
	-- Flip the y origin
	set crop of primary variant to {xPos, imageHeight - yPos, cropWidth, cropHeight}
end tell
