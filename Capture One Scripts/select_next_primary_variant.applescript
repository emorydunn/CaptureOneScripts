(*
  Shift the variant selection up or down.

  Created by Emory Dunn
*)

use application "Capture One 20"

try
	set currentVariant to primary variant
	set nextVariant to variant after currentVariant
	deselect current document variant currentVariant
	select current document variant nextVariant
end try
