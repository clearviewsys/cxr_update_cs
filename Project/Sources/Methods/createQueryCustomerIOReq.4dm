//%attributes = {}
// createQueryCustomerIOReq: Create a new Request for cab web service 
#DECLARE($custNumber : Text)->$soapRequest : Text

C_LONGINT:C283($err)
C_TEXT:C284($header; $path; $tmp)
C_TEXT:C284($root; $subElem; $soapEnv; $r; $body; $customerIO; $fcubs_header)
C_TEXT:C284($accessURL; $soapAction; $methodName; $nameSpace; $request; $subElem; $responseXML)


$nameSpace:=""
$soapAction:=""

$root:=DOM Create XML Ref:C861("soapenv:Envelope"; "http://schemas.xmlsoap.org/soap/envelope/"; "xmlns:fcub"; "http://fcubs.ofss.com/service/FCUBSCustomerService")
$header:=DOM Create XML element:C865($root; "soapenv:Header")
$body:=DOM Create XML element:C865($root; "soapenv:Body")
$request:=DOM Create XML element:C865($body; "fcub:QUERYCUSTOMER_IOFS_REQ")
$fcubs_header:=DOM Create XML element:C865($request; "fcub:FCUBS_HEADER")

$subElem:=DOM Create XML element:C865($fcubs_header; "fcub:SOURCE")
DOM SET XML ELEMENT VALUE:C868($subElem; "EXTSYS")

$subElem:=DOM Create XML element:C865($fcubs_header; "fcub:UBSCOMP")
DOM SET XML ELEMENT VALUE:C868($subElem; "FCUBS")

$subElem:=DOM Create XML element:C865($fcubs_header; "fcub:USERID")
DOM SET XML ELEMENT VALUE:C868($subElem; getKeyValue("cab.ws.user"; "ADMINUSER1"))

$subElem:=DOM Create XML element:C865($fcubs_header; "fcub:BRANCH")
DOM SET XML ELEMENT VALUE:C868($subElem; "000")

$subElem:=DOM Create XML element:C865($fcubs_header; "fcub:MODULEID")
DOM SET XML ELEMENT VALUE:C868($subElem; "ST")

$subElem:=DOM Create XML element:C865($fcubs_header; "fcub:SERVICE")
DOM SET XML ELEMENT VALUE:C868($subElem; "FCUBSCustomerService")

$subElem:=DOM Create XML element:C865($fcubs_header; "fcub:OPERATION")
DOM SET XML ELEMENT VALUE:C868($subElem; "QueryCustomer")


$body:=DOM Create XML element:C865($request; "fcub:FCUBS_BODY")
$customerIO:=DOM Create XML element:C865($body; "fcub:Customer-IO")

$subElem:=DOM Create XML element:C865($customerIO; "fcub:CUSTNO")
DOM SET XML ELEMENT VALUE:C868($subElem; $custNumber)


// Save Request XML to a file
C_TEXT:C284($request; $response)
$request:=Temporary folder:C486+"request.xml"

DOM EXPORT TO VAR:C863($root; $soapRequest)
DOM EXPORT TO FILE:C862($root; $request)
DOM CLOSE XML:C722($root)

