(*
  Process images as they are captured.

  - theRecipe: The name of the process recipe
  - useSelected: Process using the recipes enabled in Capture One.

  If `useSelected` is set to `true` the specified recipe name is ignored.

  Created by Emory Dunn
*)

(** Settings **)
set theRecipe to "*YOUR RECIPE NAME*"
set useSelected to true
(** End Settings **)

on CO_CaptureDone(rawFilePath)

	tell application "Capture One 23"
		if useSelected then
			set batchID to process rawFilePath
		else
			set batchID to process rawFilePath recipe theRecipe
		end if
	end tell

	if batchID starts with "ERROR" then
		display notification batchID with title "Error Processing Images" sound name "sosumi"
	end if

end CO_CaptureDone

