//%attributes = {}
C_OBJECT:C1216($0; $1; $credentials)
C_TEXT:C284($2; $SOAP_Method; $payloadXML)
C_OBJECT:C1216($3; $arguments; $endpoints)

$credentials:=$1
$SOAP_Method:=$2

If (Count parameters:C259>2)
	$arguments:=$3
End if 

$endpoints:=mgGetEndPoints

$payloadXML:=mgSOAP_BuildXML($credentials; $SOAP_Method; $arguments; $endpoints.soap)

$0:=mgSOAP_GetResponse($payloadXML; $SOAP_Method; $endpoints)
