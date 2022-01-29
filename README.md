# CaptureOneScripts
A collection of AppleScripts for use with Capture One.

| Script                          | Compatibility | Shortcut       |
|---------------------------------|--------------:|----------------:|
| add_capture_to_favs             | 9+            | <kbd>⌃f</kbd>
| apply_keywords                  | 10+           | <kbd>⇧⌘K</kbd>
| batch_rename_collection         | 12+           |
| make_new_dir                    | 9+            | <kbd>⌃n</kbd>
| select_next_capture             | 12+           | <kbd>⌃↑</kbd>
| select_previous_capture         | 12+           | <kbd>⌃↓</kbd>
| smart_album_for_selection       | 9+            |
| select_next_primary_variant     | 12+           |
| select_previous_primary_variant | 12+           |
| select_next_variants            | 12+           |
| select_previous_variants        | 12+           |
| move_to_archive                 | 20+           |
| camera_settings_check           | 20+           |

## Installation

Run `install.command`, which will copy the scripts to `~/Library/Scripts/Capture One Scripts` and set up the keyboard shortcuts.

Some notes:

- The script defaults to adding shortcuts for Capture One 20
- Restart Capture One after installation
- macOS might not show the shortcuts in System Preferences
- Background scripts are _not_ installed by default, please copy the ones you want to use manually

### Showing Shortcuts in System Preferences

When setting keyboard shortcuts via the command line System Preferences doesn't know to look for the shortcuts in that app. However, there is a workaround:

1. [Add a shortcut][shortcut] for Capture One. Any shortcut will do.
    - For example, just enter `Scripts` as the menu item and <kbd>⌃s</kbd> as the shortcut.
2. Quit both Capture One and System Preferences.
3. Run `install.command`
4. Remove the shortcut you added in step one.

Now the shortcuts can be customized from System Preferences.

[shortcut]: https://support.apple.com/guide/mac-help/create-keyboard-shortcuts-for-apps-mchlp2271/mac

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

Set `resetCaptureCounter` to `true` to set the capture counter to 1 when making a new folder.

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

### Select Next/Previous Primary Variant/Variants

A collection of four scripts to shift the selection of variants.

The `variants` version works with multiple selected variants, similarly to <kbd>⌘→</kbd>.

The `primary_variant` version only shifts the primary variant and will deselect any additional variants.

### Move to Archive

This script moves the images in the current collection into a central archive folder organized by date. The RAW file is relinked in the catalogue after the move. 

_Note_: Before running the script make sure to set the location of your archive. 

## The Background Scripts

Scripts in this section are run automatically by Capture One after certain events. In order for them to work they must be installed in `~/Library/Scripts/Capture One Scripts/Background Scripts`. 

### Camera Settings Check

After each new capture and checks the current camera settings against the stored defaults. If the shutter speed, aperture, or ISO have been changed it will display a notification so you can gently remind the photographer to stop nudging the dial. 

When run from the Scripts menu you can store the current settings, clear the stored settings, or run the check manually. 

_Note_: If you have settings that limit the delivery of notifications you may miss a settings change. 
