#! /bin/bash

SCRIPT_DIR=`dirname "${0}"`
INSTALL_DIR="${HOME}/Library/Scripts/Capture One Scripts"
CAPTUREONE="com.phaseone.captureone12"

ADD_SHORTCUT="defaults write ${CAPTUREONE} NSUserKeyEquivalents -dict-add"


echo "Copying scripts..."
for d in "${SCRIPT_DIR}/Capture One Scripts"/*.applescript ; do \
  echo "  ${d}"
  cp "${d}" "${INSTALL_DIR}"
done

echo "Setting keyboard shortcuts..."
${ADD_SHORTCUT} "ScriptsApplyKeywords" "@\$k"

${ADD_SHORTCUT} "ScriptsmakeNewDir" "^n"
${ADD_SHORTCUT} "ScriptsmakeNewDirNoCapture" "^\$n"

${ADD_SHORTCUT} "ScriptsselectPreviousCapture" "^↑"
${ADD_SHORTCUT} "ScriptsselectNextCapture" "^↓"

${ADD_SHORTCUT} "ScriptsAddCaptureToFavs" "^f"
echo "Done"