//%attributes = {}
// setLatestVersionDownloadURL 
C_TEXT:C284($URL; $version; $notes)

$URL:="http://www.clearviewsys.com/downloads/CXR3712.zip"
$version:="3.712"
$notes:="New Features are"


ws_setKeyValueAsText("_system"; "_donotchange"; "CXR_Structure_URL"; $URL)
ws_setKeyValueAsText("_system"; "_donotchange"; "CXR_Version"; $version)

$notes:=requestDialog("Enter some notes: ")

ws_setKeyValueAsText("_system"; "_donotchange"; "CXR_Notes"; $notes)

