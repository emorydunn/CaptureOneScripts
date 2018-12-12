(*
  Moves the capture directory down the list of favorites
  relative to the current capture directory.

  Created by Emory Dunn
*)

tell front document of application "Capture One 12"
	
	set theFolder to captures
	set captureCollection to item 1 of (collections whose folder is theFolder and user is true)
	--log name of captureCollection as string
	--log captureCollection
	
	try
		set newCapture to the collection before captureCollection
		--log name of newCapture as string
		--log newCapture
		
		if file of newCapture is equal to missing value then
			log "No file for " & name of newCapture as string
		else
			log "Setting capture dir to " & name of newCapture
			set captures to get the file of newCapture
		end if
		
	on error errMsg number errNum
		log "End of the list"
	end try
	
end tell
