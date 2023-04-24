//%attributes = {}
//author: Amir
//date: 27th Jan 2020
//retrieves address from CanadaPost Address Complete API by given ID
//CanPostAC_RetrieveAddress(
//->addressObject: pointer to array of objects to fill (for one ID, API returns two addresses, one in English and one in French);
//addressId: Id of address to get data for it)
//pointer to an object to store error in

// Unit test is written @Zoya

C_POINTER:C301($1; $arrAddressObjPtr)
C_TEXT:C284($2; $addressId)
C_POINTER:C301($3; $errorObjPtr)
C_BOOLEAN:C305($0; $success)

$arrAddressObjPtr:=$1
$addressId:=$2
$errorObjPtr:=$3

ASSERT:C1129(Type:C295($arrAddressObjPtr)=Is pointer:K8:14; "Expected pointer to array of objects to fill with address data")
ASSERT:C1129(Type:C295($arrAddressObjPtr->)=Object array:K8:28; "Expected pointer to array of objects to fill with address data")
ASSERT:C1129(Type:C295($addressId)=Is text:K8:3; "Expected text for address ID")
ASSERT:C1129(Type:C295($errorObjPtr)=Is pointer:K8:14; "Expected pointer to object to store error in")
ASSERT:C1129(Type:C295($errorObjPtr->)=Is object:K8:27; "Expected pointer to object to store error in")

C_TEXT:C284($apiKey)
$apiKey:=posGrid_GetApiKey

If ($addressId#"")
	
	C_TEXT:C284($url; $content; $response)
	$url:="http://ws1.postescanada-canadapost.ca/AddressComplete/Interactive/Retrieve/v2.10/dataset.ws?"
	$url:=$url+"&Key="+replaceUnsafeURLCharacters($apiKey)
	$url:=$url+"&Id="+replaceUnsafeURLCharacters($addressId)
	
	ARRAY TEXT:C222($headerNamesArr; 1)
	ARRAY TEXT:C222($headerValuesArr; 1)
	$headerNamesArr{1}:="Content-Type"
	$headerValuesArr{1}:="application/xhtml+xml"
	
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; 5)
	setErrorTrap(Current method name:C684; "Error connecting to Canada Post AddressComplete API")
	C_LONGINT:C283($httpStatus)
	$httpStatus:=HTTP Get:C1157($url; $response; $headerNamesArr; $headerValuesArr)
	endErrorTrap
	If ($httpStatus#200)
		$success:=False:C215
		$errorObjPtr->:=New object:C1471("errorCause"; "API connection error"; "errorDescription"; "HTTP connection to CanadaPost API error. HTTP status "+String:C10($httpStatus))
	Else 
		$success:=CanPostAC_RetrieveDeserial($arrAddressObjPtr; $response; $errorObjPtr)
		If (($success=False:C215) & ($errorObjPtr=Null:C1517))
			$errorObjPtr->:=New object:C1471("errorCause"; "Detail Response parse error"; "errorDescription"; "Error encountered during parsing XML address details response.")
		End if 
	End if 
Else 
	$success:=False:C215
End if 
$0:=$success
