(*
  Shift the variant selection up or down.

  Created by Emory Dunn
*)

use application "Capture One 20"

try
	set currentVariants to variants whose selected is true

	set nextVariants to {}
	repeat with v in currentVariants
		set nextVariant to variant after v
		copy nextVariant to the end of the |nextVariants|
	end repeat

	deselect current document variants currentVariants
	select current document variants nextVariants
end try
