//%attributes = {"shared":true}
// downloadLatestStructure
// also see: setLatestVersionDownloadURL


C_TEXT:C284($URL; $version; $notes; $0)

$URL:=ws_getKeyValueAsText("_system"; "_donotchange"; "CXR_Structure_URL")
$version:=ws_getKeyValueAsText("_system"; "_donotchange"; "CXR_Version")
$notes:=ws_getKeyValueAsText("_system"; "_donotchange"; "CXR_Notes")

If (getCurrentVersion<=$version)
	
	myConfirm("Download version "+$version+"?"+CRLF+CRLF+$notes; "Download"; "Cancel")
	If (OK=1)
		If (Length:C16($URL)>1)
			OPEN URL:C673($URL)
		End if 
	End if 
	
Else 
	myAlert("Your current version "+getCurrentVersion+" is up to date!")
End if 

$0:=""