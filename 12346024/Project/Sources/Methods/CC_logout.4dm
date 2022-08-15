//%attributes = {"shared":true}
//**************************************************************
//Method for Logging out of the Currency Cloud Platform
//
//Required Parameters:
//@Auth (String): authKey
//Optional Parameters:
//@Error (Pointer): Pointer to text variable
//
//Outputs:
//On Success: Status code 200 (String)
//On Failure: Status code of error, error message -> @Error
//**************************************************************


C_TEXT:C284($0; $1; $URL; $authKey; $response; $body)
C_LONGINT:C283($status)
C_POINTER:C301($2; $pError; $pHeaderNames; $pHeaderValues)

$authKey:=$1
If (Count parameters:C259>=2)
	ASSERT:C1129(Is nil pointer:C315($2)=False:C215)
	$pError:=$2
End if 

//No body for logout
$body:=""

//Set header names and values as text arrays
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
$pHeaderNames:=->$headerNames
$pHeaderValues:=->$headerValues
CC_setHeadersAuth($pHeaderNames; $pHeaderValues; $body; $authKey)

$URL:=CC_getUrlKeyValue
$status:=HTTP Request:C1158(HTTP POST method:K71:2; \
$URL+"/authenticate/close_session"; \
$body; $response; $headerNames; $headerValues)

$0:=String:C10($status)

CC_createLogRecord("POST authenticate/close_session"; "auth_token="+$authKey; String:C10($status); $response)


If ((Count parameters:C259>=2) & ($status#200))
	$pError->:=$response
End if 