# CaptureOneScripts
A collection of AppleScripts for use with Capture One. 

| Script                 | Compatability | Shortcut       |
|------------------------|--------------:|----------------:|
| ApplyKeywords          | 10+            | <kbd>⇧⌘K</kbd> |
| makeNewDir             | 9+             | <kbd>⌃n</kbd>  |
| makeNewDirNoCapture    | 9+             | <kbd>⌃⇧n</kbd> |
| selectNextCapture      | 9              | <kbd>⌃↑</kbd>  |
| selectPreviousCapture  | 9              | <kbd>⌃↓</kbd>  |
| smartAlbumForSelection | 9+             | |


## Installation

Run `install.sh`, which will copy the scripts to `~/Library/Scripts/Capture One Scripts` and set up the keyboard shortcuts. 

The script defaults to adding shortcuts for Capture One 11. MacOS might not show the shortcuts in System Preferences. 


## The Scripts

### ApplyKeywords

Apply keywords from the clipboard to all variants in the current collection.

Each line of text in the clipboard is applied as a separate keyword. The keywords are added to the whatever the current keywords are.

If you need to remove all keywords, use "Reset Keywords", which will remove all
keywords from every variant in the current collection.

### MakeNewDir / MakeNewDirNoCapture

Creates new directories inside of the Capture directory and sets the capture directory.

When running the script you'll be prompted for a new directory name. The prompt
will repeat allowing going back to FileMaker or a spreadsheet, enter an empty string to end the loop.

New directories are created adjacent to the current capture directory, _unless_
the capture directory is "Capture", in which case new folders are made inside.

If the boolean in `addFavorites(_:_:)` is `true` then the capture directory will be set to the *first* directory name entered.

### Select Next/ Previous Capture

Moves the capture directory up or down the list of favorites relative to the current capture directory. 

_Note_: Due to a change in how [Capture One returns favorites][favorite_order] in 10+ this script only works in Capture One 9. 

[favorite_order]: https://emorydunn.com/2018/02/27/Capture-One-Collections-and-AppleScript

### Smart Album For Selection

Creates a smart album from the name of the selected album. 

There are two parameters for configuring the search terms:

- `theDeliniator`, default `_`
- `itemNumber`, default `3`

The script splits the name on the deliniator and selects the `itemNumber` item in the new list for the search term. For instance, `some_file_name` would have a smart album called `name` made for it. 
