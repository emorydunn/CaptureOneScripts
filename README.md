# CaptureOneScripts

A collection of AppleScripts for use with Capture One.

| Script                          | Compatibility |       Shortcut |
| ------------------------------- | ------------: | -------------: |
| add_capture_to_favs             |            9+ |  <kbd>⌃f</kbd> |
| apply_keywords                  |           10+ | <kbd>⇧⌘K</kbd> |
| batch_rename_collection         |           12+ |                |
| make_new_dir                    |            9+ |  <kbd>⌃n</kbd> |
| select_next_capture             |           12+ |  <kbd>⌃↑</kbd> |
| select_previous_capture         |           12+ |  <kbd>⌃↓</kbd> |
| smart_album_for_selection       |            9+ |                |
| select_next_primary_variant     |           12+ |                |
| select_previous_primary_variant |           12+ |                |
| select_next_variants            |           12+ |                |
| select_previous_variants        |           12+ |                |
| move_to_archive                 |           20+ |                |
| camera_settings_check           |           20+ |                |
| select_9_up                     |           20+ |  <kbd>⌃9</kbd> |
| count_favorites                 |           20+ |                |
| auto_process                    |           20+ |                |
| sorted_trash                    |           20+ | <kbd>⌥⌘⌫</kbd> |
| copy_variant_names              |           20+ |                |
| add_crop_metadata               |           23+ |                |
| flip_crop                       |           23+ |                |
| clean_faves                     |           23+ |                |
| resume_counter                  |           23+ | <kbd>⌥⌘R</kbd> |
| crop_to_overlay                 |           23+ |                |
| add_suffix                      |           23+ |                |

## Installation

Run `install.command`, which will copy the scripts to `~/Library/Scripts/Capture One Scripts` and set up the keyboard shortcuts.

Some notes:

- The script defaults to adding shortcuts for Capture One 23
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
set to the _first_ directory name entered.

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

Sorts the current collection by date (ascending) and renames all variants.

By default the script will read the counter from the first variant and use that to set the rename counter. This will, in effect, rename in place. This setting can be changed to always reset the counter.

### Select Next/Previous Primary Variant/Variants

A collection of four scripts to shift the selection of variants.

The `variants` version works with multiple selected variants, similarly to <kbd>⌘→</kbd>.

The `primary_variant` version only shifts the primary variant and will deselect any additional variants.

### Move to Archive

This script moves the images in the current collection into a central archive folder organized by date. The RAW file is relinked in the catalogue after the move.

_Note_: Before running the script make sure to set the location of your archive.

### Select `n` Up

This script selects the last `n` (by default 9) images in a collection. Useful for quickly throwing up a full "page" of images for an AD or photographer to review.

### Count Favorites

A script that displays either a notification or a dialogue with the number of user favorites in the current session.

### Sorted Trash

Trash variants into subfolders based on the current image folder name. This helps keep files organized by shot, much like you might do for the Capture and Output folders, think of it as the `Image Folder Name` token name for the trash.

The downside is image will no longer be visible in the session trash, which doesn't show subfolders.

### Copy Variant Names

A small script to copy the names of every variant in the current collection to the clipboard.

### Add Crop Metadata

Save the current aspect ratio in the IPTC Content Description.

**Important Notes**

This script gets the name of the currently selected aspect ratio in the
crop tool, it does _not_ read the aspect ratio of the variant.
As such there are some limitations to what it can do.

By default this script only applies metadata to the primary variant
because the crop ratio is more likely to match the selected ratio.

When `applyToAllVariants` it's important to make sure all selected
variants actually cropped to the desired ratio.

### Flip Crop

This script flips the orientation of the crop of selected variants.

### Clean Favorites

Removes all favorites from the current session. If a favorite is also the capture folder that favorite won't be removed.

### Resume Counter

Sets the capture counter to continue from the last image in a collection.

The script uses a regular expression to read the last number in the last image to determine where the counter left off. The capture counter is then set to this number, meaning the next capture will be `n + 1`.

The script assumes a few things:

1. You're using the capture counter token at the end of the filename
2. The counter is delimited by a non-number character (`_`, `.`, etc.)

### Crop to Overlay

Crop the primary variant to the overlay, with some caveats.

We can't crop to outside of the image, so the overlay must be fully within the bounds of the image. This means the scale must be 100 or less and none of the edges of the overlay cross the image bounds.

### Add Suffix

Appends the specified suffix to variants.

Variants which already have the suffix, if any, will not be renamed.
If all variants have the suffix the suffix will be removed.
By default only selected variants are renamed.

## The Background Scripts

Scripts in this section are run automatically by Capture One after certain events. In order for them to work they must be installed in `~/Library/Scripts/Capture One Scripts/Background Scripts`.

### Camera Settings Check

After each new capture and checks the current camera settings against the stored defaults. If the shutter speed, aperture, or ISO have been changed it will display a notification so you can gently remind the photographer to stop nudging the dial.

When run from the Scripts menu you can store the current settings, clear the stored settings, or run the check manually.

#### Troubleshooting

There are a few common ways for this script to appear to not be working, usually involving notification preferences.

1. Enable notifications for Capture One and Script Editor
   1. Set the alert style to Banners or Alerts
   2. If you don't want the alerts to build up disable Show in Notification Center
2. Enable Allow Notification when mirroring or sharing the display
3. Disable Do Not Disturb
   1. Or, allow notifications from Capture One and Script Editor in Do Not Disturb

### Auto Process New Captures

After each new capture process the image using either a recipe specified in the script or with the recipes enabled in Capture One.
