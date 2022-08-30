//%attributes = {}
// calls MoneyGram SOAP API method $SOAP_Method and returns collection of objects

C_COLLECTION:C1488($resultCollection)
C_OBJECT:C1216($0; $1; $credentials; $result)
C_TEXT:C284($2; $SOAP_Method)
C_OBJECT:C1216($3; $mgSOAP_Arguments)
C_TEXT:C284($returnXML)

ASSERT:C1129(Count parameters:C259>1; "at least two parameteres required ")

$credentials:=$1
$SOAP_Method:=$2

If (Count parameters:C259>2)
	$mgSOAP_Arguments:=$3
End if 

C_BOOLEAN:C305($logmgSOAP)

$logmgSOAP:=mgLOG_isLoggingEnabled

If ($logmgSOAP)
	mgLOG($SOAP_Method+" called using credentials "+JSON Stringify:C1217($credentials; *)+" parameters "+JSON Stringify:C1217($mgSOAP_Arguments; *))
End if 

$result:=mgSOAP_Call($credentials; $SOAP_Method; $mgSOAP_Arguments)

If ($result.success)
	
	If ($result.response#"")
		
		$resultCollection:=mgSOAP_RepackCollection(mgSOAP_GetCollection($result.response))
		
		$result.result:=$resultCollection
		
	End if 
	
Else 
	
	$result.mgerrormsg:=mgSOAP_GetErrorMsg($result.response)
	$result.mgerrormsg.httpcode:=$result.err
	
End if 

$0:=$result

If ($logmgSOAP)
	mgLOG($SOAP_Method+" returned "+JSON Stringify:C1217($result; *))
End if 
