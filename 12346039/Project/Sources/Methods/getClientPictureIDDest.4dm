//%attributes = {}
// getClientPictureIDFolders ( {Client})->source
// returns both the picture ID source and destination folders

C_TEXT:C284($client; $1; $0; $destFolder)


If (Count parameters:C259=3)
	$client:=$1
Else 
	$client:=getCurrentMachineName
End if 

selectClientPrefsRecord($client)

If (Records in selection:C76([ClientPrefs:26])=1)
	$destFolder:=[ClientPrefs:26]PictureIDDestFolder:26
Else 
	$destFolder:=""
End if 

$0:=$destFolder