//%attributes = {}
//**************************************************************
//Method for creating a subaccount in the twilioAPI
//#ORDA
//
//Required Parameters:
//@pError (pointer): Pointer to a text variable where an error message
////can be stored
//
//Optional Parameters:
//@accountName: Name of the account to be created. 
////If not passed in, Name will be "SubAccount created on {date, time}"
//
//Output:
//On Success: Sid of newly created account
//On Failure: status code of error, error message filled in error field
//**************************************************************

C_LONGINT:C283($status)
C_POINTER:C301($1; $pError; $pHeaderNames; $pHeaderValues; $pBody; $pAuthToken; $pAccountSid)
C_TEXT:C284($0; $2; $accountName; $body; $response; $accountSid; $authToken; $requestUrl)
C_OBJECT:C1216($oBody; $oResponse)
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
$oBody:=New object:C1471()
$oResponse:=New object:C1471()

Case of 
	: (Count parameters:C259=1)
		$pError:=$1
	: (Count parameters:C259=2)
		$pError:=$1
		$accountName:=$2
		$oBody.FriendlyName:=$accountName
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$pHeaderNames:=->$headerNames
$pHeaderValues:=->$headerValues
$pBody:=->$body
twilioSetRequest($pHeaderNames; $pHeaderValues; $pBody; $oBody)

$pAccountSid:=->$accountSid
$pAuthToken:=->$authToken
twilioGetAuthKeys($pAccountSid; $pAuthToken)
$requestUrl:="https://"+$accountSid+":"+$authToken+"@api.twilio.com/2010-04-01/Accounts.json"

$status:=HTTP Request:C1158(HTTP POST method:K71:2; $requestUrl; $body; $response; $headerNames; $headerValues)

$oResponse:=JSON Parse:C1218($response)

If (($status=200) | ($status=201))
	$0:=$oResponse.sid
Else 
	$0:=String:C10($status)
	$pError->:="Error creating Twilio sub account: "+Char:C90(Carriage return:K15:38)+$oResponse.detail+Char:C90(Carriage return:K15:38)+"More info: "+$oResponse.more_info
End if 