//%attributes = {}
//author: Amir
// 20th Jan 2020
//Canada post address complete search
//success: bolean = CanPost_AC_Search(->arrayObject: to fill with the search result, 
//searchTerm: text, 
//country: 3 digit country code
//errorObjectPointer: pointer to an error object to store the error 
//searchId: text(optional): Id of previous search)
//documentation at https://www.canadapost.ca/pca/support/webservice/addresscomplete/interactive/find/2.1/

// Unit test is written

C_POINTER:C301($1; $arrProcessedAddressObjPtr)
C_TEXT:C284($2; $searchTerm)
C_TEXT:C284($3; $country)
C_POINTER:C301($4; $errorObjPtr)
C_TEXT:C284($5; $previousSearchId)
C_BOOLEAN:C305($0; $success)

$arrProcessedAddressObjPtr:=$1
$searchTerm:=$2
$country:=$3
$errorObjPtr:=$4
$previousSearchId:=$5

ASSERT:C1129(Type:C295($arrProcessedAddressObjPtr)=Is pointer:K8:14; "Expected pointer to object")
ASSERT:C1129(Type:C295($arrProcessedAddressObjPtr->)=Object array:K8:28; "Expected pointer to object")
ASSERT:C1129(Type:C295($searchTerm)=Is text:K8:3; "Expected text for search term")
ASSERT:C1129(Type:C295($country)=Is text:K8:3; "Expected text for country code")
ASSERT:C1129(Length:C16($country)=3; "Expected 3 digit country code")
ASSERT:C1129(Type:C295($errorObjPtr)=Is pointer:K8:14; "Expected pointer to object for error")
ASSERT:C1129(Type:C295($errorObjPtr->)=Is object:K8:27; "Expected pointer to object for error")

If (Count parameters:C259=5)
	$previousSearchId:=$5
	ASSERT:C1129(Type:C295($previousSearchId)=Is text:K8:3; "Expected text for previous search ID")
	ASSERT:C1129($previousSearchId#""; "Expected non-empty text for previous search ID")
Else 
	If (Count parameters:C259#4)
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End if 
End if 


If ($searchTerm#"")
	C_TEXT:C284($apiKey)
	$apiKey:=CanPostAC_GetApiKey
	C_LONGINT:C283($maxSuggestions; $httpStatus)
	$maxSuggestions:=10
	
	C_TEXT:C284($url; $content; $response)
	$url:="http://ws1.postescanada-canadapost.ca/AddressComplete/Interactive/Find/v2.10/dataset.ws?"
	$url:=$url+"Key="+replaceUnsafeURLCharacters($apiKey)
	$url:=$url+"&SearchTerm="+replaceUnsafeURLCharacters($searchTerm)
	$url:=$url+"&Country="+replaceUnsafeURLCharacters($country)
	$url:=$url+"&MaxSuggestions="+String:C10($maxSuggestions)
	$url:=$url+"&MaxResults="+String:C10($maxSuggestions)
	
	If ($previousSearchId#"")
		$url:=$url+"&LastId="+$previousSearchId
	End if 
	
	ARRAY TEXT:C222($headerNamesArr; 1)
	ARRAY TEXT:C222($headerValuesArr; 1)
	$headerNamesArr{1}:="Content-Type"
	$headerValuesArr{1}:="application/xhtml+xml"
	
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; 5)
	
	setErrorTrap(Current method name:C684; "Error connecting to Canada Post AddressComplete API")
	$httpStatus:=HTTP Get:C1157($url; $response; $headerNamesArr; $headerValuesArr)
	endErrorTrap
	
	If ($httpStatus#200)
		$success:=False:C215
		$errorObjPtr->:=New object:C1471("errorCause"; "API connection error"; "errorDescription"; "HTTP connection to CanadaPost API error. HTTP status "+String:C10($httpStatus))
	Else 
		ARRAY OBJECT:C1221($arrAddressSearchPreProcessed; 0)
		//some of these addresses from the deserializer, that have 'find' in action, require further search
		$success:=CanPostAC_SearchDeserial(->$arrAddressSearchPreProcessed; $response; $errorObjPtr)
		If ($success=True:C214)
			CanPostAC_ProcessSearchResult($arrProcessedAddressObjPtr; ->$arrAddressSearchPreProcessed; $country; $errorObjPtr; $searchTerm)
		End if 
	End if 
	
Else 
	$success:=False:C215
End if 
$0:=$success


