--
--	Created by: Emory Dunn
--	Created on: 5/5/23
--
--	Copyright © 2023 Lost Cause Photographic, LLC, All Rights Reserved
--

use scripting additions
use application "Capture One"

set textBody to ""
repeat with v in variants
	set textBody to textBody & name of v & "
"
end repeat

set the clipboard to textBody
