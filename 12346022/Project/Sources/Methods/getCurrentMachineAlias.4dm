//%attributes = {}
// getClientMachineAlias ( {Client})-machineAlias

C_TEXT:C284($client; $1; $0; $result)


If (Count parameters:C259=1)
	$client:=$1
Else 
	$client:=getCurrentMachineName
End if 

selectClientPrefsRecord($client)

If (Records in selection:C76([ClientPrefs:26])=1)
	$result:=[ClientPrefs:26]ComputerAlias:33
Else 
	$result:=getCurrentMachineName
End if 

$0:=$result