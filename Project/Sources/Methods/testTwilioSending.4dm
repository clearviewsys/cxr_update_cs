//%attributes = {}
C_TEXT:C284($requestUrl; $modifiedUrl; $accountSid; $body; $response; $authToken; $authText)
C_OBJECT:C1216($requestParams; $oError)
C_LONGINT:C283($status; $i)
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
ARRAY TEXT:C222($bodyArray; 0)

$accountSid:="ACa07f6d6fe3b629afad0817f279f5fd18"
$authToken:="a978ef0fec87afbfdbcaf7b7956f96ae"
$requestUrl:="https://"+$accountSid+":"+$authToken+"@api.twilio.com/2010-04-01/Accounts/"+$accountSid+"/Messages.json"

$requestParams:=New object:C1471()

$requestParams.To:="+17788880784"
$requestParams.Body:="This is a test message from 4D using twilio"
$requestParams.From:="+17788006177"

OB GET PROPERTY NAMES:C1232($requestParams; $bodyArray)
For ($i; 1; Size of array:C274($bodyArray))
	If ($i>1)
		$body:=$body+"&"
	End if 
	$body:=$body+$bodyArray{$i}+"="+$requestParams[$bodyArray{$i}]
End for 


APPEND TO ARRAY:C911($headerNames; "Content-Type")
APPEND TO ARRAY:C911($headerValues; "application/x-www-form-urlencoded")
APPEND TO ARRAY:C911($headerNames; "Content-Length")
APPEND TO ARRAY:C911($headerValues; String:C10(Length:C16($body)))

$status:=HTTP Request:C1158(HTTP POST method:K71:2; $requestUrl; $body; $response; $headerNames; $headerValues)

$oError:=JSON Parse:C1218($response)

