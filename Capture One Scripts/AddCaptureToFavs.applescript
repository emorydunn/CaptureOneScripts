(*
	Add the current Capture Directory to favorites

	Created by Emory Dunn

*)
tell front document of application "Capture One 12"
	set captureCollection to make collection with properties {kind:favorite, file:captures}
end tell