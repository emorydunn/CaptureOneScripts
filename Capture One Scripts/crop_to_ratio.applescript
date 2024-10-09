(**
	Created by: Emory Dunn
	Created on: 2024-10-09

	Copyright © 2024 Emory Dunn, All Rights Reserved

	Apply a crop with the specified ratio to the primary variant

**)

use application "Capture One"

set ratio to 9 / 16

log ratio

set imageSize to dimensions of parent image of primary variant

set imageWidth to item 1 of imageSize
set imageHeight to item 2 of imageSize

if ratio > 1 then
	set newCrop to {imageWidth, imageWidth * 1 / ratio}
else
	set newCrop to {imageHeight * ratio, imageHeight}
end if

log newCrop

set crop size of primary variant to newCrop
