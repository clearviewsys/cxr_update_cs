//%attributes = {}
//author: Amir
//date: 2nd October 2019
//deserializes error response

//example of error response as argument for this function:
//{"status":400,"statusText":"BAD_REQUEST","timestamp":"2019-10-01T06:30:59.542","message":"{\\"status\\":400,\\"statusText\\":\\"BAD_REQUEST\\",\\"timestamp\\":\\"2019-10-01T06:30:59.541\\",\\"message\\":\\"Invalid Country, sourceCountryCode=SEsdfsf is invalid\\"}"}

C_TEXT:C284($1; $errorResponseJson)
C_POINTER:C301($2; $responseObjPtr)

$errorResponseJson:=$1
$responseObjPtr:=$2

ASSERT:C1129(Type:C295($errorResponseJson)=Is text:K8:3; "Expected a text with json format")
ASSERT:C1129(Type:C295($responseObjPtr)=Is pointer:K8:14; "Expected a pointer to an object")
ASSERT:C1129(Type:C295($responseObjPtr->)=Object array:K8:28; "Expected a pointer to an object")

If (Not:C34($errorResponseJson=""))
	APPEND TO ARRAY:C911($responseObjPtr->; JSON Parse:C1218($errorResponseJson))
End if 