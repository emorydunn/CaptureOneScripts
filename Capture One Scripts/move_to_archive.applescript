(*

 Move photos in the current collection to an external archive. 
 
 The files are organized by capture date or 
 file creation date with the following structure:
  
  `<year>/<month number> <month name>/<day>`
  
  e.g. `2020/08 August/14`

  Created by Emory Dunn
*)

(* Options *)
set rootArchive to POSIX path of "/Volumes/Photogravure/Archive/"

# If you'd prefer to copy or link the files 
# instead of moving them, enter a different command here
set moveCommand to "mv"

(* Script *)
tell front document of application "Capture One 20"
	
	set theImages to images
	
	tell application "Capture One 20"
		set progress completed units to 0
		set progress total units to count of theImages
		set progress text to "Moving files to Archive"
	end tell
	
	repeat with thePhoto in theImages
		
		if EXIF capture date of thePhoto is missing value then
			set thePath to path of thePhoto
			tell application "Finder"
				set theDate to creation date of (POSIX file thePath as alias)
			end tell
		else
			set theDate to EXIF capture date of thePhoto
		end if
		
		
		set theFolder to my createFolder(rootArchive, theDate)
		
		set newLocation to theFolder & "/" & name of thePhoto
		
		do shell script moveCommand & " " & "'" & path of thePhoto & "'" & " " & "'" & theFolder & "'"
		relink thePhoto to path newLocation
		
		tell application "Capture One 20"
			set progress completed units to progress completed units + 1
		end tell
		
	end repeat
	
end tell


on createFolder(rootArchive, theDate)
	set the theYear to year of theDate as string
	set the theMonthNumber to my padNumber(month of theDate as number)
	set the theMonthName to month of theDate as string
	set the theDay to day of theDate as string
	
	set theDatePath to theYear & "/" & theMonthNumber & " " & theMonthName & "/" & theDay
	set theFullPath to rootArchive & theDatePath
	
	do shell script "mkdir -p '" & theFullPath & "'"
	
	return theFullPath
	
end createFolder

on padNumber(theNumber)
	if theNumber is less than 10 then
		return "0" & theNumber
	else
		return theNumber as string
	end if
end padNumber
