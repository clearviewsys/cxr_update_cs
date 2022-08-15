//%attributes = {}
//**************************************************************
//Method for closing a subAccount in the Twilio API
//#ORDA
//
//Required Parameters:
//@pError (pointer): Pointer to a text variable where an error message
////can be stored
//@subAccountSid (Text): The Sid of the subaccount to be closed
//
//
//Output:
//On Success: Object containing account details of closed account 
//On Failure: Object with error field containing status,
////error message applied to error poiner
//**************************************************************

C_OBJECT:C1216($0; $oResponse; $obody)
C_TEXT:C284($2; $body; $response; $accountSid; $authToken; $requestUrl; $subAccountSid)
C_POINTER:C301($pError; $pHeaderNames; $pHeaderValues; $pBody; $pAccountSid; $pAuthToken; $1)
C_LONGINT:C283($status)
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
$oResponse:=New object:C1471()
$oBody:=New object:C1471()
$body:=""

Case of 
	: (Count parameters:C259=2)
		$pError:=$1
		$subAccountSid:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$oBody.Status:="closed"
//Set body string and request headers
$pHeaderNames:=->$headerNames
$pHeaderValues:=->$headerValues
$pBody:=->$body
twilioSetRequest($pHeaderNames; $pHeaderValues; $pBody; $oBody)

//Get accountSid and AuthToken
$pAccountSid:=->$accountSid
$pAuthToken:=->$authToken
twilioGetAuthKeys($pAccountSid; $pAuthToken)
$requestUrl:="https://"+$accountSid+":"+$authToken+"@api.twilio.com/2010-04-01/Accounts/"+$subAccountSid+".json"


//Send request
$status:=HTTP Request:C1158(HTTP POST method:K71:2; $requestUrl; $body; $response; $headerNames; $headerValues)

//Read response & deal with errors
$oResponse:=JSON Parse:C1218($response)

If ($status=200)
	$0:=$oResponse
	
Else 
	$0:=New object:C1471("error"; $oResponse.status)
	$pError->:=$oResponse.message
End if 

