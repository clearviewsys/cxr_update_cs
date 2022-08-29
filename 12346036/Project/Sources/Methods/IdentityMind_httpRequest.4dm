//%attributes = {}
// IdentityMind_httpRequest($httpMethod;{$json};$postfix)
// Do a IdentityMind HTTP request, and show error if any is found.
//
// Paramters
// $httpMethod (C_TEXT)
//     HTTP method for request (see  HTTP Request)
// $json (C_TEXT)
//     the data in a JSON string
// $postfix  (C_TEXT)
//     the postfix text, if any
// 
// Return: 
//     the result of the IdentityMind code, or empty string if there are errors

// === PART 1: Setup Paramters ===

C_TEXT:C284($1; $httpMethod)  // for HTTP Request
C_TEXT:C284($2; $postfix)  // (optional) input json
C_OBJECT:C1216($3; $json)  // URL postfix
C_OBJECT:C1216($0; $response)
Case of 
	: (Count parameters:C259=2)
		$httpMethod:=$1
		$postfix:=$2
		$json:=Null:C1517
	: (Count parameters:C259=3)
		$httpMethod:=$1
		$postfix:=$2
		$json:=$3
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 
ASSERT:C1129(IdentityMindStage#"")
ASSERT:C1129(IdentityMindUser#"")
ASSERT:C1129(IdentityMindPass#"")

// === PART 2: Setup HTTP Request Inputs

// URL
C_TEXT:C284($url)
$url:="https://"+IdentityMindStage+".identitymind.com/"+$postfix

// HTTP header name/value lists
ARRAY TEXT:C222($headerNames; 1)
ARRAY TEXT:C222($headerValues; 1)

C_TEXT:C284($authorizeRaw; $authorized)
C_BLOB:C604($setupBlob)
$authorizeRaw:=IdentityMindUser+":"+IdentityMindPass
TEXT TO BLOB:C554($authorizeRaw; $blob; UTF8 text without length:K22:17)
BASE64 ENCODE:C895($blob; $authorized)

$headerNames{1}:="Authorization"
$headerValues{1}:="Basic "+$authorized

// === PART 3: Send data ===

C_TEXT:C284($timeout_raw)
EXECUTE METHOD:C1007("getKeyValue"; $timeout_raw; "identityMind.HTTPRequestTimeout"; "7")
C_REAL:C285($timeout)
$timeout:=Num:C11($timeout_raw)
HTTP SET OPTION:C1160(HTTP timeout:K71:10; $timeout)

C_OBJECT:C1216($response)
$response:=New object:C1471

C_REAL:C285($status)
$status:=0
C_TIME:C306($startTime)
$startTime:=Current time:C178
ON ERR CALL:C155("identityMind_handleHttpError")
$status:=HTTP Request:C1158($httpMethod; $url; $json; $response; $headerNames; $headerValues)
C_TIME:C306($duration)
$duration:=Current time:C178-$startTime
ON ERR CALL:C155("")

// === PART 4: Output data or show error

$0:=Null:C1517
Case of 
	: ($status=0)
		C_TEXT:C284($message)
		$message:="IdentityMind is taken too long to response. Please try again later."
		$message:=$message+"\nTime waited: "+String:C10($duration)
		myAlert($message; "IdentityMind Error")
		$0:=Null:C1517
		
	: ($status#200)
		C_TEXT:C284($text)
		$text:=""
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($headerNames))
			If ($text#"")
				$text:=$text+"\n"
			End if 
			$text:=$text+$headerNames{$i}+": "+$headerValues{$i}
		End for 
		$text:=$text+"\n"+JSON Stringify:C1217($response; *)
		EXECUTE METHOD:C1007("myAlert"; *; $text; "Identity Mind - HTTP "+String:C10($status)+" Error")
		$0:=Null:C1517
	Else 
		$0:=$response
End case 