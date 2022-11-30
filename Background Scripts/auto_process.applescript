(*
  Process images as they are captured. 
  
  - theRecipe: The name of the process recipe
  - useSelected: Process using the recipes enabled in Capture One. 
  
  If `useSelected` is set to `true` the specified recipe name is ignored. 

  Created by Emory Dunn
*)


on CO_CaptureDone(rawFilePath)
	
	(** Settings **)
	set theRecipe to "*YOUR RECIPE NAME*"
	set useSelected to true
	(** End Settings **)
	
	tell application "Capture One 22"
		if useSelected then
			process rawFilePath
		else
			process rawFilePath recipe theRecipe
		end if
	end tell
	
end CO_CaptureDone
