--
--	Created by: Emory Dunn
--	Created on: 2018-03-13
--
--	Copyright © 2018 Emory Dunn, All Rights Reserved
--

use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

on run

	-- Parameters
	set theDelimiter to "_"
	set itemNumber to 3

	-- Script below

	tell front document of application "Capture One 12" to set selectedItem to current collection

	set theName to my theSplit(name of selectedItem, theDelimiter)
	set theNameComponent to item itemNumber of theName

	set theRules to "<?xml version=\"1.0\" encoding=\"UTF-8\"?><MatchOperator Kind=\"AND\"><MatchOperator Kind=\"AND\"><Condition Enabled=\"YES\"><Key>displayName</Key><Operator>6</Operator><Criterion>" & theNameComponent & "</Criterion></Condition></MatchOperator></MatchOperator>"

	tell front document of application "Capture One 12"
		make new collection with properties {name:theNameComponent, kind:smart album, rules:theRules}
	end tell
end run

on theSplit(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	-- create the array
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the result
	return theArray
end theSplit