//%attributes = {}
// 
// ws_getCustomerTransactionHistory
// http://registrationserver.net/webservices/CXWebServices.asmx?WSDL
// 
// Method source code automatically generated by the 4D SOAP wizard.
// ----------------------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($0)

C_TEXT:C284($root)
C_TEXT:C284($subelem)
C_TEXT:C284($namespace)
$namespace:="http://webservices.registrationserver.net/"
$root:=DOM Create XML Ref:C861("getCustomerTransactionHistory"; $namespace)

$subelem:=DOM Create XML element:C865($root; "/getCustomerTransactionHistory/clientCode")
DOM SET XML ELEMENT VALUE:C868($subelem; $1)

$subelem:=DOM Create XML element:C865($root; "/getCustomerTransactionHistory/clientKey")
DOM SET XML ELEMENT VALUE:C868($subelem; $2)

$subelem:=DOM Create XML element:C865($root; "/getCustomerTransactionHistory/customerId")
DOM SET XML ELEMENT VALUE:C868($subelem; $3)

$subelem:=DOM Create XML element:C865($root; "/getCustomerTransactionHistory/period")
DOM SET XML ELEMENT VALUE:C868($subelem; $4)

WEB SERVICE SET PARAMETER:C777("XMLIn"; $root)

WEB SERVICE CALL:C778("http://registrationserver.net/webservices/CXWebServices.asmx"; "http://webservices.registrationserver.net/getCustomerTransactionHistory"; "getCustomerTransactionHistory"; "http://webservices.registrationserver.net/"; Web Service manual:K48:4)

If (OK=1)
	C_BLOB:C604($blob)
	C_TEXT:C284($resroot)
	C_TEXT:C284($ressubelem)
	WEB SERVICE GET RESULT:C779($blob; "XMLOut"; *)
	$resroot:=DOM Parse XML variable:C720($blob)
	
	$ressubelem:=DOM Find XML element:C864($resroot; "/getCustomerTransactionHistoryResponse/getCustomerTransactionHistoryResult")
	DOM GET XML ELEMENT VALUE:C731($ressubelem; $0)
	DOM CLOSE XML:C722($resroot)
	
End if 

DOM CLOSE XML:C722($root)

