//%attributes = {}
//bulkValidateEmailsWithZeroBounce()

// Unit test is written @Vitor
C_COLLECTION:C1488($emailsCollection; $1)
C_TEXT:C284($api_key; $url)
C_OBJECT:C1216($body; $headers; $response)

$body:=New object:C1471
Case of 
	: (Count parameters:C259=1)
		$emailsCollection:=$1
		$api_key:=getKeyValue("zeroBounce.apiKey"; "noKeySet")
		
		$body.email_batch:=$emailsCollection
		$body.api_key:=$api_key
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$url:="https://bulkapi.zerobounce.net/v2/validatebatch"

$headers:=New object:C1471
$headers["Content-Type"]:="application/json"

$response:=HTTPRequest("POST"; $url; $body; $headers)
$0:=$response