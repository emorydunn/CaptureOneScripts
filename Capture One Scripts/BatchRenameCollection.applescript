use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

tell front document of application "Capture One 11"
  --  Sort by date
  --activate
  --my menu_click(["Capture One 11", "View", "Sort", "Date"])

  -- Get current collections variants
  set theVariants to every variant of current collection
  log "Renaming " & number of theVariants & " variants"

  -- Batch rename
  set counter of batch rename settings to 1
  batch rename variants theVariants
end tell

-- From http://hints.macworld.com/article.php?story=20060921045743404
on menu_click(mList)
  local appName, topMenu, r

  -- Validate our input
  if mList's length < 3 then error "Menu list is not long enough"

  -- Set these variables for clarity and brevity later on
  set {appName, topMenu} to (items 1 through 2 of mList)
  set r to (items 3 through (mList's length) of mList)

  -- This overly-long line calls the menu_recurse function with
  -- two arguments: r, and a reference to the top-level menu
  tell application "System Events" to my menu_click_recurse(r, ((process appName)'s ¬
    (menu bar 1)'s (menu bar item topMenu)'s (menu topMenu)))
end menu_click

on menu_click_recurse(mList, parentObject)
  local f, r

  -- `f` = first item, `r` = rest of items
  set f to item 1 of mList
  if mList's length > 1 then set r to (items 2 through (mList's length) of mList)

  -- either actually click the menu item, or recurse again
  tell application "System Events"
    if mList's length is 1 then
      click parentObject's menu item f
    else
      my menu_click_recurse(r, (parentObject's (menu item f)'s (menu f)))
    end if
  end tell
end menu_click_recurse
