//%attributes = {}
//**************************************************************
//Method for sending a SMS request to Twilio
//#ORDA
//
//Required Parameters:
//@pError (pointer): Pointer to a text variable where an error message
////can be stored
//@toNumber (string): The number to send the SMS to, must be registered
////with the given twilio account
//@message (string): Pointer to a text array 
//**************************************************************
//Optional Parameters:
//@fromNumber (String): The number to send the SMS from, must be registered
////with the given twilio account
//**************************************************************
//Output:
//On Success: 200 status code
//On Failure: Status code of error, error message -> @pError
//**************************************************************

C_OBJECT:C1216($oBody; $oResponse)
C_TEXT:C284($toNumber; $message; $fromNumber; $body; $response; $accountSid; $authToken; $requestUrl; $errorBalance; $0; $2; $3; $4)
C_POINTER:C301($pError; $pHeaderNames; $pHeaderValues; $pBody; $pAccountSid; $pAuthToken; $pErrorBalance; $1)
C_LONGINT:C283($status; $balance; $numTexts)
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
$oBody:=New object:C1471()
$oResponse:=New object:C1471()
$fromNumber:=""
$0:=""

Case of 
	: (Count parameters:C259=3)
		$pError:=$1
		$toNumber:=$2
		$message:=$3
	: (Count parameters:C259=4)
		$pError:=$1
		$toNumber:=$2
		$message:=$3
		$fromNumber:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//Create the body object
If (Substring:C12($toNumber; 1; 1)="+")
	$oBody.To:=$toNumber
Else 
	$oBody.To:="+"+$toNumber
End if 

$oBody.Body:=$message

If (Length:C16($fromNumber)>0)
	If (Substring:C12($fromNumber; 1; 1)#"+")
		$fromNumber:="+"+$fromNumber
	End if 
Else 
	//Get default from number from keyValues
	$fromNumber:=<>twilioDefaultFromNumber  //getKeyValue ("twilio.fromNumber")
End if 
$oBody.From:=$fromNumber

//Set body string and request headers
$pHeaderNames:=->$headerNames
$pHeaderValues:=->$headerValues
$pBody:=->$body
twilioSetRequest($pHeaderNames; $pHeaderValues; $pBody; $oBody)

//Get accountSid and AuthToken
$pAccountSid:=->$accountSid
$pAuthToken:=->$authToken
twilioGetAuthKeys($pAccountSid; $pAuthToken)
If (getKeyValue("twilio.subAccount.activated")="True")
	$requestUrl:="https://"+$accountSid+":"+$authToken+"@api.twilio.com/2010-04-01/Accounts/"+getKeyValue("twilio.subAccount.sid")+"/Messages.json"
Else 
	$requestUrl:="https://"+$accountSid+":"+$authToken+"@api.twilio.com/2010-04-01/Accounts/"+$accountSid+"/Messages.json"
End if 

//Twilio text messages have max length of 160 characters
//Check if the account has enough of a balance to send the text
//The number of segments a text is broken into will change if the 
//Content is in UCS-2 encoding. This check is not 100% guaranteed,
//But it will work for regular-text content
//Any other failures will be received from the response
$numTexts:=(Length:C16($body)/160)+1
$balance:=Num:C11(getKeyValue("twilio.accountTextBalance"))

If ($balance>=$numTexts)
	//Send request
	$status:=HTTP Request:C1158(HTTP POST method:K71:2; $requestUrl; $body; $response; $headerNames; $headerValues)
	
	//Read response & deal with errors
	$oResponse:=JSON Parse:C1218($response)
	
	If (($status=201) | ($status=200))
		$0:="200"
		twilioDecreaseTextBalance(Num:C11($oResponse.num_segments))
		twilioLogMessage($message; $toNumber; $fromNumber; ""; String:C10($status))
	Else 
		$pError->:=$oResponse.message+" : "+$oResponse.more_info  //ibb added more info 7/5/20
		$0:=String:C10($oResponse.status)
		twilioLogMessage($message; $toNumber; $fromNumber; $oResponse.message; String:C10($status))
	End if 
Else 
	$0:=String:C10(400)
	$pError->:="Not enough money in twilio account to send the given text"
	twilioLogMessage($message; $toNumber; $fromNumber; $pError->; String:C10($status))
End if 

