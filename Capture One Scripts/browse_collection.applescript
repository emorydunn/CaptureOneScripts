(**
	Created by: Emory Dunn
	Created on: 2022-11-11

	Copyright © 2022 Emory Dunn, All Rights Reserved

	Open a existing collection in Capture One.
**)-- Settingsset theCollection to "_TEST"-- Scripttell front document of application "Capture One 22"		try		set current collection to collection named theCollection	on error errMsg number errNum		log "No collection called " & theCollection	end try	end tell