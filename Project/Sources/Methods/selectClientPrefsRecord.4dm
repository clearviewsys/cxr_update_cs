//%attributes = {}
// getClientPrefsField ({clientName}) : 

C_TEXT:C284($clientName; $1)

If (Count parameters:C259=1)
	$clientName:=$1
Else 
	$clientName:=getCurrentMachineName
End if 
READ ONLY:C145([ClientPrefs:26])
QUERY:C277([ClientPrefs:26]; [ClientPrefs:26]ClientName:1=$clientName)
