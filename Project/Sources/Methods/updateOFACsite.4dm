//%attributes = {}
C_TEXT:C284($clientCode; $clientKey; $1; $2)
C_TEXT:C284($error)

Case of 
	: (Count parameters:C259=2)
		$clientCode:=$1
		$clientkey:=$2
	Else 
		$clientCode:="tiran"
		$clientKey:="1"
End case 

CONFIRM:C162("This will disrupt access to OFAC while update is being done"; "Update"; "Cancel")
If (OK=1)
	//$error:=ws_UpdateOFAC ($clientCode,$clientKey)
	myAlert("This feature has been disabled. Updating must be done from registrationserver.net")
End if 