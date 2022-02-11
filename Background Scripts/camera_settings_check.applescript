(*
  Check camera settings after each capture. 

  Created by Emory Dunn
*)

on CO_CaptureDone(rawFilePath)
	checkSettings()
end CO_CaptureDone

on checkSettings()
	try
		set savedSettings to getSettings()
		
		tell application "Capture One"
			set theISO to ISO of camera of current document
			set theShutter to shutter speed of camera of current document
			set theAperture to aperture of camera of current document
		end tell
		
		set errors to ""
		
		if iso of savedSettings is not equal to theISO then
			set errors to "• ISO is not " & iso of savedSettings & "
" & errors
		end if
		
		if shutter of savedSettings is not equal to theShutter then
			set errors to "• Shutter Speed is not " & shutter of savedSettings & "
" & errors
		end if
		
		if aperture of savedSettings is not equal to theAperture then
			set errors to "• Aperture is not f/" & aperture of savedSettings & "
" & errors
		end if
		
		if (count of errors) is not 0 then
			display notification errors with title "Camera Settings Error" sound name "sosumi"
		end if
	on error errMsg number errNum
		log errMsg
		(* 
		Uncomment the following line to be notified of any script errors. 
		
		Intended for debugging only. 
		
		This will potentially post a lot of notifications, specifically if there
		aren't any saved settings. 
		*)
		
		-- display notification errMsg with title "Error Retreiving Settings" sound name "sosumi"
	end try
end checkSettings

on setSettings()
	try
		tell application "Capture One"
			set theISO to ISO of camera of current document
			set theShutter to shutter speed of camera of current document
			set theAperture to aperture of camera of current document
		end tell
		
		do shell script "defaults write photo.lostcause.CameraWarning iso " & theISO
		do shell script "defaults write photo.lostcause.CameraWarning shutterSpeed " & theShutter
		do shell script "defaults write photo.lostcause.CameraWarning aperture " & theAperture
	on error errMsg number errNum
		display alert "No Camera Connected" message "Please connect a camera or select it in the current document."
	end try
	
end setSettings

on getSettings()
	set theISO to do shell script "defaults read photo.lostcause.CameraWarning iso"
	set theShutter to do shell script "defaults read photo.lostcause.CameraWarning shutterSpeed"
	set theAperture to do shell script "defaults read photo.lostcause.CameraWarning aperture"
	
	return {iso:theISO, shutter:theShutter, aperture:theAperture}
end getSettings

on clearSettings()
	do shell script "defaults delete photo.lostcause.CameraWarning"
end clearSettings

try
	try
		set dialogAnswer to display dialog "Store current camera settings?" buttons {"Check", "Clear Settings", "Save"} default button 3 cancel button 2
	on error errMsg number errNum
		log "Clear Settings"
		clearSettings()
	end try
	
	if button returned of dialogAnswer is "Save" then
		log "Save Settings"
		setSettings()
	else if button returned of dialogAnswer is "Check" then
		log "Check Settings"
		checkSettings()
	end if
end try

