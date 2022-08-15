//%attributes = {}
// One Parameter
// validateEmailWithZeroBounce(string: $email) -> Object: $response
// Optional Second Parameter
// validateEmailWithZeroBounce(string: $email, string: $ip_address) -> Object: $response
// @viktor
// Unit test is written @Viktor

C_TEXT:C284($email; $1)
C_TEXT:C284($ip_address; $2)
C_TEXT:C284($api_key; $url)
C_OBJECT:C1216($body; $headers)
C_OBJECT:C1216($response; $0)

$body:=New object:C1471
Case of 
	: (Count parameters:C259=1)
		$email:=Lowercase:C14($1)  //ibb per lotus
		$api_key:=getKeyValue("zeroBounce.apiKey"; "noKeySet")
		
		$body.email:=$email
		$body.api_key:=$api_key
	: (Count parameters:C259=2)
		$email:=$1
		$ip_address:=$2
		$api_key:=getKeyValue("zeroBounce.apiKey"; "noKeySet")
		
		$body.email:=$email
		$body.ip_address:=$ip_address
		$body.api_key:=$api_key
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$url:="https://api.zerobounce.net/v2/validate"

$headers:=New object:C1471
$headers["Content-Type"]:="application/x-www-form-urlencoded"

// SHould I check if there are enough credits or get a bad response

$response:=HTTPRequest("POST"; $url; $body; $headers)

$0:=$response