//%attributes = {}

C_TEXT:C284($api_key)
C_OBJECT:C1216($response)

$api_key:=getKeyValue("zeroBounce.apiKey"; "noKeySet")

$response:=HTTPRequest(HTTP GET method:K71:1; "https://api.zerobounce.net/v2/getcredits?api_key="+$api_key)
If ($response.status=200)
	$0:=$response.response.Credits
Else 
	$0:="-1"
End if 