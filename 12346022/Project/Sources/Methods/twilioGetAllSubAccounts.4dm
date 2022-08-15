//%attributes = {}
//**************************************************************
//Method for getting all subaccounts from the Twilio API
//#ORDA
//
//Required Parameters:
//@pError (pointer): Pointer to a text variable where an error message
////can be stored
//
//Output:
//On Success: Object containing array of accounts (maximum of first 50 accounts)
//On Failure: Object containing error message, error message set in pError field
//**************************************************************

C_OBJECT:C1216($0; $oResponse; $oBody)
C_TEXT:C284($body; $response; $accountSid; $authToken; $requestUrl)
C_POINTER:C301($pError; $pHeaderNames; $pHeaderValues; $pBody; $pAccountSid; $pAuthToken)
C_LONGINT:C283($status)
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
$oResponse:=New object:C1471()
$oBody:=New object:C1471()
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
$requestUrl:="https://"+$accountSid+":"+$authToken+"@api.twilio.com/2010-04-01/Accounts.json?Status=active"


//Send request
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $requestUrl; $body; $response; $headerNames; $headerValues)

//Read response & deal with errors
$oResponse:=JSON Parse:C1218($response)

If ($status=200)
	$0:=$oResponse
	
Else 
	$0:=New object:C1471("error"; $oResponse.status)
	$pError->:=$oResponse.message
End if 

