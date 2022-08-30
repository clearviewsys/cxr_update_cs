//%attributes = {}
//Author: Amir, 13th March 2020
//geocoding address (returning lat, long coordinates) using google API
//success<boolean> = googleGeocodeAddressString(address to geocode<text>; 
//                                           pointer to object to store result in <C_POINTER>
//                                           pointer to object to store error in <C_POINTER>)
//                                           [optional] Google API key <C_TEXT> : use getKeyValue("Google.geocode.api.key"))

// Unit test is written @Zoya
C_TEXT:C284($address; $1)
C_POINTER:C301($resultObjectPtr; $2)
C_POINTER:C301($errorObjPtr; $3)

$address:=$1
$resultObjectPtr:=$2
$errorObjPtr:=$3

C_TEXT:C284($googleApiKey)
Case of 
	: (Count parameters:C259=3)
		$googleApiKey:=getKeyValue("Google.geocode.api.key"; "")
	: (Count parameters:C259=4)
		C_TEXT:C284($4)
		$googleApiKey:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BOOLEAN:C305($success; $0)

$success:=False:C215

ASSERT:C1129(Type:C295($address)=Is text:K8:3; "Expected text for address")
ASSERT:C1129($address#""; "Expected non-empty text for address")
ASSERT:C1129(Type:C295($resultObjectPtr)=Is pointer:K8:14; "Expected pointer to object to store geocode result")
ASSERT:C1129(Type:C295($resultObjectPtr->)=Is object:K8:27; "Expected pointer to object to store geocode result")
ASSERT:C1129(Type:C295($errorObjPtr)=Is pointer:K8:14; "Expected pointer to object to store error in")
ASSERT:C1129(Type:C295($errorObjPtr->)=Is object:K8:27; "Expected pointer to object to store error in")
ASSERT:C1129(Type:C295($googleApiKey)=Is text:K8:3; "Expected non-empty text for google API key")
ASSERT:C1129($googleApiKey#""; "Expected non-empty text for google API key")

ARRAY TEXT:C222($headerNamesArr; 1)
ARRAY TEXT:C222($headerValuesArr; 1)
$headerNamesArr{1}:="Content-Type"
$headerValuesArr{1}:="text/html"

HTTP SET OPTION:C1160(HTTP timeout:K71:10; 5)
C_TEXT:C284($url; $response)
C_LONGINT:C283($httpStatus)

$url:="https://maps.googleapis.com/maps/api/geocode/json?address="
$url:=$url+replaceUnsafeURLCharacters($address)
$url:=$url+"&key="+$googleApiKey

setErrorTrap(Current method name:C684; "Error connecting to geocoding Google API server")
$httpStatus:=HTTP Get:C1157($url; $response; $headerNamesArr; $headerValuesArr)
endErrorTrap
C_OBJECT:C1216($responseObj)
$responseObj:=JSON Parse:C1218($response)
If (($httpStatus#200) | Not:C34(Undefined:C82($responseObj.error_message)))
	$success:=False:C215
	$errorObjPtr->:=New object:C1471("error_message"; "Error connecting to Google Geocoding API: "+String:C10($responseObj.error_message))
Else 
	ARRAY OBJECT:C1221($rawObjArray; 0)
	JSON PARSE ARRAY:C1219(JSON Stringify:C1217($responseObj.results); $rawObjArray)
	If (Not:C34(Undefined:C82($rawObjArray{1}.geometry.location.lat)) & Not:C34(Undefined:C82($rawObjArray{1}.geometry.location.lng)))
		$resultObjectPtr->:=New object:C1471("lat"; $rawObjArray{1}.geometry.location.lat; "lng"; $rawObjArray{1}.geometry.location.lng)
		$success:=True:C214
	Else 
		$errorObjPtr->:=New object:C1471("error_message"; "Error: did not receive any result from Google Geocoding API for given address")
		$success:=False:C215
	End if 
	
End if 

$0:=$success

