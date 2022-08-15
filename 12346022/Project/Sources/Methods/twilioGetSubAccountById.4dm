//%attributes = {}
//**************************************************************
//Method for retreiving a single subaccount from the Twilio API by it's ID
//#ORDA
//
//Required Parameters:
//@pError (pointer): Pointer to a text variable where an error message
////can be stored
//@subAccounId (text): Id of subaccount to be retreived
//
//Output:
//On Success: Friendly name of account associated to Id
//On Failure: Status code of response, error message sent to pError
//**************************************************************

C_OBJECT:C1216($oResponse; $oBody)
C_TEXT:C284($body; $response; $accountSid; $authToken; $requestUrl; $subAccountSid; $0; $2)
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
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $requestUrl; $body; $response; $headerNames; $headerValues)

//Read response & deal with errors
$oResponse:=JSON Parse:C1218($response)

If ($status=200)
	$0:=$oResponse.friendly_name
	
Else 
	$0:=String:C10($oResponse.status)
	$pError->:=$oResponse.message
End if 

