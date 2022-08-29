//%attributes = {}
//author: Amir
//date: 8th Oct 2019
//search person by legal ID 
//tested for SWEDEN
//isSuccess(Boolean) := BsndCI_searchPersonByLegalId(
//                pointer to array of object to store response in;
//                text: unique id (LegalId);        
//)
C_BOOLEAN:C305($0; $isSuccess)
C_POINTER:C301($1; $resultArrObjPtr)
C_TEXT:C284($2; $legalId)


$resultArrObjPtr:=$1
$legalId:=$2

ASSERT:C1129(Type:C295($1)=Is pointer:K8:14; "Expected pointer to array of objects")
ASSERT:C1129(Type:C295($1->)=Object array:K8:28; "Expected pointer to array of objects")
ASSERT:C1129(Type:C295($2)=Is text:K8:3; "Expected text for legal id")

If (Not:C34(Count parameters:C259=2))
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 

C_TEXT:C284($sourceCountry)
$sourceCountry:=getKeyValue("BisN.country"; "SE")

$isSuccess:=BisN_ensureAccessToken
If (Not:C34($isSuccess))
	$0:=False:C215
	APPEND TO ARRAY:C911($resultArrObjPtr->; <>BisnodeCI_accessToken)  //contains error information
Else 
	C_TEXT:C284($response)
	C_TEXT:C284($requestURI)
	C_LONGINT:C283($responseStatusCode)
	ARRAY TEXT:C222($headerNamesArr; 3)
	ARRAY TEXT:C222($headerValuesArr; 3)
	$headerNamesArr{1}:="Accept"
	$headerValuesArr{1}:="application/json"
	$headerNamesArr{2}:="charset"
	$headerValuesArr{2}:="UTF-8"
	$headerNamesArr{3}:="Authorization"
	$headerValuesArr{3}:="Bearer "+<>BisnodeCI_accessToken.access_token
	setErrorTrap(Current method name:C684; "Error connecting to BisNode Service")
	$requestURI:=BisN_getPersonBaseUrl+"/person/search?"+"legalId="+$legalId+"&sourceCountry="+$sourceCountry
	$responseStatusCode:=HTTP Get:C1157($requestURI; $response; $headerNamesArr; $headerValuesArr)
	
	If ($responseStatusCode=200)
		$0:=True:C214
		BisN_deserializePersonResponse($response; $resultArrObjPtr)
	Else 
		$0:=False:C215
		BisN_deserializeErrResponse($response; $resultArrObjPtr)
	End if 
	endErrorTrap
End if 
