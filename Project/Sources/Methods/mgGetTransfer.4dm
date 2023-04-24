//%attributes = {}
C_OBJECT:C1216($1; $parameters)
C_OBJECT:C1216($0; $result; $mgCredentials)

$parameters:=$1
$mgCredentials:=mgGetCredentials

If ($mgCredentials#Null:C1517)
	
	$result:=mgSOAP_RunMethod($mgCredentials; "GetTransfer"; $parameters)
	
	$0:=$result
	
End if 
