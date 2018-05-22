(*
  Moves the capture directory up the list of favorites
  relative to the current capture directory.

  Created by Emory Dunn
*)

tell front document of application "Capture One 9"
  set currentCaptureDir to captures
  set captureCollection to make collection with properties {kind:favorite, file:currentCaptureDir}
  log captureCollection

  set currentIndex to my list_position(currentCaptureDir, collections)

  set nextIndex to currentIndex - 1
  try
    set nextCaptureDir to file of collection [nextIndex]
    set captures to nextCaptureDir
    return 0
  end try

  return 1

end tell

on list_position(this_item, this_list)
  repeat with i from 1 to the count of this_list
    try
      if file of item i of this_list is this_item then return i
    end try
  end repeat
  return -1
end list_position