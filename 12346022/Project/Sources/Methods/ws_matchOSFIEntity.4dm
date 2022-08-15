//%attributes = {}
// 
// ws_matchOSFIEntity
// http://registrationserver.net/cxblacklist/CXBlackList.asmx?WSDL
// 
// Method source code automatically generated by the 4D SOAP wizard.
// ----------------------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($0)

C_TEXT:C284($root)
C_TEXT:C284($subelem)
C_TEXT:C284($namespace)
$namespace:="http://tempuri.org/"
$root:=DOM Create XML Ref:C861("matchOSFIEntity"; $namespace)

$subelem:=DOM Create XML element:C865($root; "/matchOSFIEntity/clientCode")
DOM SET XML ELEMENT VALUE:C868($subelem; $1)

$subelem:=DOM Create XML element:C865($root; "/matchOSFIEntity/clientKey")
DOM SET XML ELEMENT VALUE:C868($subelem; $2)

$subelem:=DOM Create XML element:C865($root; "/matchOSFIEntity/entityName")
DOM SET XML ELEMENT VALUE:C868($subelem; $3)

WEB SERVICE SET PARAMETER:C777("XMLIn"; $root)

WEB SERVICE CALL:C778("http://registrationserver.net/cxblacklist/CXBlackList.asmx"; "http://tempuri.org/matchOSFIEntity"; "matchOSFIEntity"; "http://tempuri.org/"; Web Service manual:K48:4)

If (OK=1)
	C_BLOB:C604($blob)
	C_TEXT:C284($resroot)
	C_TEXT:C284($ressubelem)
	WEB SERVICE GET RESULT:C779($blob; "XMLOut"; *)
	$resroot:=DOM Parse XML variable:C720($blob)
	
	$ressubelem:=DOM Find XML element:C864($resroot; "/matchOSFIEntityResponse/matchOSFIEntityResult")
	DOM GET XML ELEMENT VALUE:C731($ressubelem; $0)
	DOM CLOSE XML:C722($resroot)
Else 
	$0:="Could not connect to OSFI server. Entity could not be checked. "
End if 

DOM CLOSE XML:C722($root)

