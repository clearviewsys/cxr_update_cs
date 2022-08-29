//%attributes = {}
//**************************************************************
//Method for getting the account balance from the current Twilio account
//
//Required Parameters:
//@pError (pointer): Pointer to a text variable where an error message
////can be stored
//
//Output:
//On Success: Balance in the current account
//On Failure: Status code of error, error message -> @pError
//**************************************************************

C_OBJECT:C1216($oResponse; $oBody)
C_TEXT:C284($body; $response; $accountSid; $authToken; $requestUrl; $2; $3; $4)
C_POINTER:C301($pError; $pHeaderNames; $pHeaderValues; $pBody; $pAccountSid; $pAuthToken; $1)
C_LONGINT:C283($status)
C_REAL:C285($0)
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
$oResponse:=New object:C1471()
$body:=""

Case of 
	: (Count parameters:C259=1)
		$pError:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//Set body string and request headers
$pHeaderNames:=->$headerNames
$pHeaderValues:=->$headerValues
$pBody:=->$body
twilioSetRequest($pHeaderNames; $pHeaderValues; $pBody; $oBody)

//Get accountSid and AuthToken
$pAccountSid:=->$accountSid
$pAuthToken:=->$authToken
twilioGetAuthKeys($pAccountSid; $pAuthToken)
$requestUrl:="https://"+$accountSid+":"+$authToken+"@api.twilio.com/2010-04-01/Accounts/"+$accountSid+"/Balance.json"
//Send request
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $requestUrl; $body; $response; $headerNames; $headerValues)

//Read response & deal with errors
$oResponse:=JSON Parse:C1218($response)

If ($status=200)
	$0:=Num:C11($oResponse.balance)
	
	
Else 
	$0:=$oResponse.status
	$pError->:=$oResponse.message
End if 

