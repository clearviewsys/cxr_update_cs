//%attributes = {}
// 
// ws_updateMacAddress
// http://registrationserver.net/webservices/CXWebServices.asmx?WSDL
// 
// Method source code automatically generated by the 4D SOAP wizard.
// ----------------------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_TEXT:C284($6)
C_BOOLEAN:C305($0)

C_TEXT:C284($root)
C_TEXT:C284($subelem)
C_TEXT:C284($namespace)
$namespace:="http://webservices.registrationserver.net/"
$root:=DOM Create XML Ref:C861("updateMacAddress"; $namespace)

$subelem:=DOM Create XML element:C865($root; "/updateMacAddress/user")
DOM SET XML ELEMENT VALUE:C868($subelem; $1)

$subelem:=DOM Create XML element:C865($root; "/updateMacAddress/password")
DOM SET XML ELEMENT VALUE:C868($subelem; $2)

$subelem:=DOM Create XML element:C865($root; "/updateMacAddress/macAddress")
DOM SET XML ELEMENT VALUE:C868($subelem; $3)

$subelem:=DOM Create XML element:C865($root; "/updateMacAddress/clientCode")
DOM SET XML ELEMENT VALUE:C868($subelem; $4)

$subelem:=DOM Create XML element:C865($root; "/updateMacAddress/computerName")
DOM SET XML ELEMENT VALUE:C868($subelem; $5)

$subelem:=DOM Create XML element:C865($root; "/updateMacAddress/expiryDate")
DOM SET XML ELEMENT VALUE:C868($subelem; $6)

WEB SERVICE SET PARAMETER:C777("XMLIn"; $root)

WEB SERVICE CALL:C778("http://registrationserver.net/webservices/CXWebServices.asmx"; "http://webservices.registrationserver.net/updateMacAddress"; "updateMacAddress"; "http://webservices.registrationserver.net/"; Web Service manual:K48:4)

If (OK=1)
	C_BLOB:C604($blob)
	C_TEXT:C284($resroot)
	C_TEXT:C284($ressubelem)
	WEB SERVICE GET RESULT:C779($blob; "XMLOut"; *)
	$resroot:=DOM Parse XML variable:C720($blob)
	
	$ressubelem:=DOM Find XML element:C864($resroot; "/updateMacAddressResponse/updateMacAddressResult")
	DOM GET XML ELEMENT VALUE:C731($ressubelem; $0)
	DOM CLOSE XML:C722($resroot)
	
End if 

DOM CLOSE XML:C722($root)

