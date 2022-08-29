//%attributes = {}
// 
// ws_getRateString
// http://registrationserver.net/cxrate/RateServices.asmx?WSDL
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
C_LONGINT:C283($iTries)
$namespace:="http://cxrate.registrationserver.net/"
$root:=DOM Create XML Ref:C861("getRateString"; $namespace)

$subelem:=DOM Create XML element:C865($root; "/getRateString/ClientCode")
DOM SET XML ELEMENT VALUE:C868($subelem; $1)

$subelem:=DOM Create XML element:C865($root; "/getRateString/ClientKey")
DOM SET XML ELEMENT VALUE:C868($subelem; $2)

$subelem:=DOM Create XML element:C865($root; "/getRateString/From")
DOM SET XML ELEMENT VALUE:C868($subelem; $3)

$subelem:=DOM Create XML element:C865($root; "/getRateString/To")
DOM SET XML ELEMENT VALUE:C868($subelem; $4)

WEB SERVICE SET PARAMETER:C777("XMLIn"; $root)
WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9; 5)  //4/12/21 IBB

$iTries:=0
Repeat   //5/1/21 based on tests done by shaun and issues with lotus fiji
	$iTries:=$iTries+1
	WEB SERVICE CALL:C778("http://registrationserver.net/cxrate/RateServices.asmx"; "http://cxrate.registrationserver.net/getRateString"; "getRateString"; "http://cxrate.registrationserver.net/"; Web Service manual:K48:4)
	
	If (OK=0)
		DELAY PROCESS:C323(Current process:C322; 10)
	End if 
Until ((OK=1) | ($iTries>=5))


If (OK=1)
	C_BLOB:C604($blob)
	C_TEXT:C284($resroot)
	C_TEXT:C284($ressubelem)
	WEB SERVICE GET RESULT:C779($blob; "XMLOut"; *)
	$resroot:=DOM Parse XML variable:C720($blob)
	
	$ressubelem:=DOM Find XML element:C864($resroot; "/getRateStringResponse/getRateStringResult")
	DOM GET XML ELEMENT VALUE:C731($ressubelem; $0)
	DOM CLOSE XML:C722($resroot)
	
End if 

DOM CLOSE XML:C722($root)

