//%attributes = {}
// returns collection of all states from MoneyGram API
// there is no possibility to filter this before the call

C_OBJECT:C1216($0; $parameters; $result; $mgCredentials)

$mgCredentials:=mgGetCredentials

If ($mgCredentials#Null:C1517)
	
	$result:=mgSOAP_RunMethod($mgCredentials; "GetStates"; $parameters)
	
End if 

$0:=$result
