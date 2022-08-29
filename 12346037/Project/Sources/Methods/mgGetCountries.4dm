//%attributes = {}
// returns collection of countries from MoneyGram SOAP API

C_OBJECT:C1216($0; $result; $mgCredentials)

$mgCredentials:=mgGetCredentials

If ($mgCredentials#Null:C1517)
	
	$result:=mgSOAP_RunMethod($mgCredentials; "GetCountries")
	
End if 

$0:=$result
