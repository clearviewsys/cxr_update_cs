//%attributes = {}
// getClientPictureIDFolders (->sourceFolder ; ->destFolder ; {Client})
// returns both the picture ID source and destination folders

C_POINTER:C301($1; $2; $sourcePtr; $destPtr)
C_TEXT:C284($client; $3)

$sourcePtr:=$1
$destPtr:=$2

If (Count parameters:C259=3)
	$client:=$3
Else 
	$client:=getCurrentMachineName
End if 

selectClientPrefsRecord($client)

If (Records in selection:C76([ClientPrefs:26])=1)
	$sourcePtr->:=[ClientPrefs:26]PictureIDSourceFolder:25
	$destPtr->:=[ClientPrefs:26]PictureIDDestFolder:26
Else 
	$sourcePtr->:=""
	$destPtr->:=""
End if 