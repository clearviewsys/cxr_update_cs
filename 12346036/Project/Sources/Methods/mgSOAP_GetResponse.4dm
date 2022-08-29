//%attributes = {}
// connects to MG SOAP API method $SOAPMethod passing $payLoadXML with links in $endpoints
C_TEXT:C284($1; $payLoadXML; $certFolderPath; $responseXML)
C_TEXT:C284($2; $SOAP_Method)
C_OBJECT:C1216($3; $endpoints; $0)
C_LONGINT:C283($err)

$payLoadXML:=$1
$SOAP_Method:=$2

If (Count parameters:C259>2)
	$endpoints:=$3
Else 
	$endpoints:=mgGetEndPoints
End if 

$0:=New object:C1471
$0.success:=False:C215
$certFolderPath:=mgGetCertificatesPath

If (($payloadXML#"") & ($SOAP_Method#"") & ($certFolderPath#""))
	
	mgSetHTTPCertificates($certFolderPath)
	
	ARRAY TEXT:C222($headerNames; 0)
	ARRAY TEXT:C222($headerValues; 0)
	
	If ($payloadXML#"")
		APPEND TO ARRAY:C911($headerNames; "Content-Type")
		APPEND TO ARRAY:C911($headerValues; "text/xml")
		APPEND TO ARRAY:C911($headerNames; "SOAPAction")
		APPEND TO ARRAY:C911($headerValues; $endpoints.soap.namespace1+$SOAP_Method)
		APPEND TO ARRAY:C911($headerNames; "Content-Length")
		APPEND TO ARRAY:C911($headerValues; String:C10(Length:C16($payloadXML)))
	End if 
	
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; 120)
	$err:=HTTP Request:C1158(HTTP POST method:K71:2; $endpoints.soap.soapURL; $payloadXML; $responseXML; $headerNames; $headerValues)
	
	$0.err:=$err
	$0.response:=$responseXML
	
	If ($err=200)
		$0.success:=True:C214
	End if 
	
End if 
