(**
	Created by: Emory Dunn
	Created on: 2024-01-17

	Copyright © 2024 Emory Dunn, All Rights Reserved

	Remove all favorites from a session.
**)

tell front document of application "Capture One 23"
	try
		delete (every collection whose kind is favorite)
	end try
end tell
