# CaptureOneScripts
A collection of AppleScripts for use with Capture One.

| Script                    | Compatability | Shortcut       |
|---------------------------|--------------:|----------------:|
| add_capture_to_favs       | 9+            | <kbd>⌃f</kbd>
| apply_keywords            | 10+           | <kbd>⇧⌘K</kbd>
| batch_rename_collection   | 12            |
| make_new_dir              | 9+            | <kbd>⌃n</kbd>
| select_next_capture       | 12            | <kbd>⌃↑</kbd>
| select_previous_capture   | 12            | <kbd>⌃↓</kbd>
| smart_album_for_selection | 9+            |


## Installation

Run `install.command`, which will copy the scripts to `~/Library/Scripts/Capture One Scripts` and set up the keyboard shortcuts.

Some notes:

- The script defaults to adding shortcuts for Capture One 20.
- Capture One should be restarted after installation
- MacOS might not show the shortcuts in System Preferences.


## The Scripts

### Add Capture to Favs

Adds the current Capture Directory to favorites

### Apply Keywords

Apply keywords from the clipboard to all variants in the current collection.

Each line of text in the clipboard is applied as a separate keyword. The keywords are added to the whatever the current keywords are.

If you need to remove all keywords, use "Reset Keywords", which will remove all
keywords from every variant in the current collection.

### Make New Dir

Creates new directories inside of the Capture directory and sets the capture directory.

When running the script you'll be prompted for a new directory name. The prompt
will repeat allowing going back to FileMaker or a spreadsheet, enter an empty string to end the loop.

New directories are created adjacent to the current capture directory, _unless_
the capture directory is "Capture", in which case new folders are made inside.

  Set `repeatPrompt` to `false` to only prompt for one name.

  If `setCaptureFolder` is `true` then the capture directory will be
  set to the *first* directory name entered.

### Select Next/ Previous Capture

Moves the capture directory up or down the list of favorites relative to the current capture directory.

_Note_: The new versions of these scripts will only work in Capture One 12 and later.

[favorite_order]: https://emorydunn.com/2018/02/27/Capture-One-Collections-and-AppleScript

### Smart Album For Selection

Creates a smart album from the name of the selected album.

There are two parameters for configuring the search terms:

- `theDelimiter`, default `_`
- `itemNumber`, default `3`

The script splits the name on the delimiter and selects the `itemNumber` item in the new list for the search term. For instance, `some_file_name` would have a smart album called `name` made for it.

### Batch Rename Collection

Sorts the current collection by date (ascending), sets the rename counter to 1, and renames all variants.
