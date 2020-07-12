#! /bin/bash

SCRIPT_DIR=`dirname "${0}"`
INSTALL_DIR="${HOME}/Library/Scripts/Capture One Scripts"
CAPTUREONE="com.captureone.captureone13"

ADD_SHORTCUT="defaults write ${CAPTUREONE} NSUserKeyEquivalents -dict-add"


echo "Copying scripts..."
for d in "${SCRIPT_DIR}/Capture One Scripts"/*.applescript ; do \
  echo "  ${d}"
  cp "${d}" "${INSTALL_DIR}"
done

echo "Setting keyboard shortcuts..."
${ADD_SHORTCUT} "Scriptsapply_keywords" "@\$k"

${ADD_SHORTCUT} "Scriptsmake_new_dir" "^n"

${ADD_SHORTCUT} "Scriptsselect_previous_capture" "^↑"
${ADD_SHORTCUT} "Scriptsselect_next_capture" "^↓"

${ADD_SHORTCUT} "Scriptsadd_capture_to_favs" "^f"
echo "Done"