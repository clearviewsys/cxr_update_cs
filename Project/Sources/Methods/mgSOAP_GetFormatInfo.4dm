//%attributes = {}
C_OBJECT:C1216($0; $parameters; $result; $mgCredentials)

$mgCredentials:=mgGetCredentials

If ($mgCredentials#Null:C1517)
	
	// calling mgSOAP_Call directly because of the difference in result format
	
	$result:=mgSOAP_Call($mgCredentials; "GetFormatInfo")
	
	If ($result.success)
		$result.formatInfo:=mgSOAP_XtrctGetFormatInfoResult($result.response)
	End if 
	
End if 

$0:=$result
