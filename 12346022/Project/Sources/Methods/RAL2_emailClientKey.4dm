//%attributes = {}
//Method for emailing a client Key to a user
//Parameters: Client Code or Email (string)
//Optional: Email (boolean) idicates if the first parameter is the email or client code

//Parameters
C_TEXT:C284($0; $1; $code)
C_BOOLEAN:C305($2; $email)
//Internal
C_TEXT:C284($params; $body; $response; $requestUrl)
C_POINTER:C301($pHeaderNames; $pHeaderValues; $pParams)
C_LONGINT:C283($status)
C_OBJECT:C1216($oParams; $oResponse)
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
$oParams:=New object:C1471()

Case of 
	: (Count parameters:C259=2)
		$code:=$1
		$email:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$oParams.ralKey:=RAL2_getRALKey
If ($email)
	$oParams.email:=$code
Else 
	$oParams.clientCode:=$code
End if 

$pHeaderNames:=->$headerNames
$pHeaderValues:=->$headerValues
$pParams:=->$params
HTTPSetRequest($pHeaderNames; $pHeaderValues; $pParams; $oParams)

$requestUrl:="https://cloud.clearviewsys.net/ral/json/emailClientKey?"+$params

ON ERR CALL:C155("RAL2_errMethod")
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $requestUrl; $body; $response)

$response:="{\"array\":"+$response+"}"
$oResponse:=JSON Parse:C1218($response)
ON ERR CALL:C155("")

//Possible responses are 
//0: Success
//1: Server error
//2: Input Error
//11: User's registration is not activated/confirmed
//18: Client Not found
If ($status=200)
	$0:=$oResponse.array[0]
Else 
	$0:="1"
End if 

