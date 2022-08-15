//%attributes = {}
// Gets list of document types MoneyGram accepts - passport, drivers license, etc.

C_OBJECT:C1216($0; $result; $mgCredentials)

$mgCredentials:=mgGetCredentials

$result:=mgSOAP_RunMethod($mgCredentials; "GetDocumentTypeList")

$0:=$result
