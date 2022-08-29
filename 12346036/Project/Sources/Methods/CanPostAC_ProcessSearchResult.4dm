//%attributes = {}
//author: Amir
//30th Jan 2020
//Canada post address complete API
//processes search results from CanPostAC_Search

C_POINTER:C301($1; $arrAddressProcessedObjectsPtr)
C_POINTER:C301($2; $arrAddressSearchObjectsPtr)
C_TEXT:C284($3; $country)
C_POINTER:C301($4; $errorObjPtr)
C_TEXT:C284($5; $searchTerm)

$arrAddressProcessedObjectsPtr:=$1  //pointer to store results
$arrAddressSearchObjectsPtr:=$2  //pointer to unprocessed search results
$country:=$3
$errorObjPtr:=$4
$searchTerm:=$5

ASSERT:C1129(Type:C295($arrAddressProcessedObjectsPtr)=Is pointer:K8:14; "Expected pointer to array of objects to store processed addresses in")
ASSERT:C1129(Type:C295($arrAddressProcessedObjectsPtr->)=Object array:K8:28; "Expected pointer to array of objects to store processed addresses in")

ASSERT:C1129(Type:C295($arrAddressSearchObjectsPtr)=Is pointer:K8:14; "Expected pointer to array of objects for input search result")
ASSERT:C1129(Type:C295($arrAddressSearchObjectsPtr->)=Object array:K8:28; "Expected pointer to array of objects for input search result")

ASSERT:C1129(Type:C295($country)=Is text:K8:3; "Expected text for country code")
ASSERT:C1129(Length:C16($country)=3; "Expected 3 digit country code")

ASSERT:C1129(Type:C295($errorObjPtr)=Is pointer:K8:14; "Expected pointer to object for error")
ASSERT:C1129(Type:C295($errorObjPtr->)=Is object:K8:27; "Expected pointer to object for error")

ASSERT:C1129(Type:C295($searchTerm)=Is text:K8:3; "Expected text for search term")
ASSERT:C1129($searchTerm#""; "Expected non empty text for search term")

C_LONGINT:C283($i; $k)
C_BOOLEAN:C305($success)
ARRAY OBJECT:C1221($temp; 0)
For ($i; 1; Size of array:C274($arrAddressSearchObjectsPtr->))
	If ($arrAddressSearchObjectsPtr->{$i}.action="Retrieve")  //these ones are ready to retrieve
		APPEND TO ARRAY:C911($arrAddressProcessedObjectsPtr->; $arrAddressSearchObjectsPtr->{$i})
	End if 
	
	If ($arrAddressSearchObjectsPtr->{$i}.action="Find")  //these require extra search with last id
		$success:=CanPostAC_Search(->$temp; $searchTerm; $country; $errorObjPtr; $arrAddressSearchObjectsPtr->{$i}.id)
		If ($success=True:C214)
			For ($k; 1; Size of array:C274($temp))
				If ($temp{$k}.action="Retrieve")
					APPEND TO ARRAY:C911($arrAddressProcessedObjectsPtr->; $temp{$k})
				End if 
			End for 
		End if 
	End if 
End for 