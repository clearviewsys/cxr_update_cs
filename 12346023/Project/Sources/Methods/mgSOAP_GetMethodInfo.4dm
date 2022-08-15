//%attributes = {}
C_TEXT:C284($1; $method; $payloadXML; $root; $xml)
C_OBJECT:C1216($2; $parameters; $xmlObj)
C_OBJECT:C1216($0; $result; $mgCredentials; $arguments; $endpoints)

$method:=$1
$parameters:=$2

$mgCredentials:=mgGetCredentials

If (($mgCredentials#Null:C1517) & ($method#""))
	
	$endpoints:=mgGetEndPoints
	
	// GetMethodInfo has different SOAP Envelope format
	
	$payloadXML:=mgSOAP_BuildGetMethodInfoXML($mgCredentials; $method; $parameters; $endpoints.soap)
	
	// SET TEXT TO PASTEBOARD($payloadXML)
	
	$result:=mgSOAP_GetResponse($payloadXML; "GetMethodInfo"; $endpoints)
	
	If ($result.success)
		
		// TRACE
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
