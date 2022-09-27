(*
  Show the number of user favorites.

  Created by Emory Dunn
*)

-- Settings

set shouldDisplayNotification to false

-- Script

tell front document of application "Capture One 22"
	set favCount to count of (every collection whose user is true and kind is favorite)
	if shouldDisplayNotification then
		display notification "There are " & (favCount) & " favorites"
	else
		display dialog "There are " & (favCount) & " favorites" buttons {"OK"} default button "OK"
	end if
end tell
