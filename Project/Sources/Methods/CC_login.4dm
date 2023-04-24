//%attributes = {"shared":true}
//**************************************************************
//Method for Logging into the Currency Cloud Platform
//
//Required Parameters:
//@Auth (String): email and apiKey
//Optional Parameters:
//@Error (Pointer): Pointer to text variable
//
//Outputs:
//On Success: Authentication key (String)
//On Failure: Status code of error, error message -> @Error
//**************************************************************


C_TEXT:C284($0; $1; $2; $URL; $loginId; $apiKey; $body; $response)
C_POINTER:C301($3; $pError; $pHeaderNames; $pHeaderValues)
C_LONGINT:C283($status)

$loginId:=$1
$apiKey:=$2
If (Count parameters:C259=3)
	ASSERT:C1129(Is nil pointer:C315($3)=False:C215)
	$pError:=$3
End if 

//Set body in x-www-form-urlencoded format
$body:="login_id="+$loginId
$body:=$body+"&api_key="+$apiKey

ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
$pHeaderNames:=->$headerNames
$pHeaderValues:=->$headerValues
CC_setHeaders($pHeaderNames; $pHeaderValues; $body)

$URL:=CC_getUrlKeyValue
$status:=HTTP Request:C1158(HTTP POST method:K71:2; $URL+"/authenticate/api"; $body; $response; $headerNames; $headerValues)

CC_createLogRecord("POST authenitcate/api (login)"; $body; String:C10($status); $response)

If ($status=200)
	C_TEXT:C284($auth_key)
	
	//Simple response so can be parsed by position
	$auth_key:=Substring:C12($response; 16; 32)
	
	$0:=$auth_key
	
Else 
	If (Count parameters:C259>=3)
		$pError->:=$response
	End if 
	$0:=String:C10($status)
End if 
