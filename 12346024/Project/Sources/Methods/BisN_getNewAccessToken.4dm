//%attributes = {}
//author:Amir
//24th Sept 2019
//gets access token object for given client id and secret, given in text array
//boolean(success indicator) := BisnodeCI_getAccessToken(
//->clientID and secret array;
//->object to fill with access token or error message properties )



C_POINTER:C301($1; $clientCredentialsArr)
ASSERT:C1129(Type:C295($1->)=Text array:K8:16; "Expected pointer to text array for client id and secret")
ASSERT:C1129(Size of array:C274($1->)=2; "Expected pointer to text array of length 2 for client id and secret")

C_POINTER:C301($2; $accessTokenObjPtr)
ASSERT:C1129(Type:C295($2->)=Is object:K8:27; "Expected pointer to object to store access token information in")

C_TEXT:C284($environment)
$environment:=BisN_getEnvironment

$clientCredentialsArr:=$1
$accessTokenObjPtr:=$2

C_TEXT:C284($response)

C_LONGINT:C283($responseStatusCode)
ARRAY TEXT:C222($headerNamesArr; 1)
ARRAY TEXT:C222($headerValuesArr; 1)
$headerNamesArr{1}:="Content-Type"
$headerValuesArr{1}:="application/x-www-form-urlencoded"

ARRAY TEXT:C222($requestDataArr; 0)
BisN_getTokenRequestData(->$requestDataArr)
C_TEXT:C284($requestData; $authUrl)
$requestData:=$requestDataArr{1}
$authUrl:=$requestDataArr{2}

setErrorTrap(Current method name:C684; "Error authenticating with Bisnode API service.")
HTTP AUTHENTICATE:C1161($clientCredentialsArr->{1}; $clientCredentialsArr->{2}; 1)
$responseStatusCode:=HTTP Request:C1158(HTTP POST method:K71:2; $authUrl; $requestData; $response; $headerNamesArr; $headerValuesArr)

C_OBJECT:C1216($responseObject)
$responseObject:=JSON Parse:C1218($response)
$accessTokenObjPtr->:=$responseObject

C_BOOLEAN:C305($0)
If ($responseStatusCode=200)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
endErrorTrap

