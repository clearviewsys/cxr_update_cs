//%attributes = {}
C_TEXT:C284($1; $method; $payloadXML; $root; $xml)
C_OBJECT:C1216($2; $parameters; $xmlObj)
C_OBJECT:C1216($0; $result; $mgCredentials; $arguments; $endpoints)

$method:=$1
$parameters:=$2

$mgCredentials:=mgGetCredentials

If (($mgCredentials#Null:C1517) & ($method#""))
	
	C_BOOLEAN:C305($logmgSOAP)
	
	$logmgSOAP:=mgLOG_isLoggingEnabled
	
	$endpoints:=mgGetEndPoints
	
	// GetMethodInfo has different SOAP Envelope format
	
	$payloadXML:=mgSOAP_BuildGetMethodInfoXML($mgCredentials; $method; $parameters; $endpoints.soap)
	
	// SET TEXT TO PASTEBOARD($payloadXML)
	
	If ($logmgSOAP)
		mgLOG("GetMethodInfo called using credentials "+JSON Stringify:C1217($mgCredentials; *)+" parameters "+JSON Stringify:C1217($parameters; *))
		mgLOG("GetMethodInfo payload\n\n"+$payloadXML)
	End if 
	
	$result:=mgSOAP_GetResponse($payloadXML; "GetMethodInfo"; $endpoints)
	
	If ($result.success)
		
		$xml:=$result.response
		$root:=DOM Parse XML variable:C720($xml)
		$xmlObj:=mgXML2Object($root)
		DOM CLOSE XML:C722($root)
		
		$result.result:=mgGetSubObject($xmlObj; "GetMethodInfoResult")
		
	Else 
		
		$result.mgerrormsg:=mgSOAP_GetErrorMsg($result.response)
		$result.mgerrormsg.httpcode:=$result.err
		
	End if 
	
End if 

$0:=$result

If ($logmgSOAP)
	mgLOG("GetMethodInfo returned "+JSON Stringify:C1217($result; *))
End if 
