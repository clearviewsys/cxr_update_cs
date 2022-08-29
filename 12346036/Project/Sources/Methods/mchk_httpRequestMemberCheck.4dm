//%attributes = {}
// mchk_httpRequestMemberCheck($httpMethod;$path;{$body})
//
// Send a HTTP Request to MemberCheck
//
// Parameters:
// $httpMethod (C_TEXT):
//    Is either the constants: HTTP POST method, HTTP GET method
// $path (C_TEXT):
//     the path of the url
// $body (C_OBJECT)
//     the content of the HTTP Request
//
// Return:
//    the result and the status of the HTTP Request


C_OBJECT:C1216($0; $result)
C_TEXT:C284($1; $httpMethod)
C_TEXT:C284($2; $path)
C_OBJECT:C1216($3; $body)
Case of 
	: (Count parameters:C259=2)
		$httpMethod:=$1
		$path:=$2
		$body:=New object:C1471
	: (Count parameters:C259=3)
		$httpMethod:=$1
		$path:=$2
		$body:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($url)
C_TEXT:C284($mChkStatus)
$mChkStatus:=getKeyValue("MemberCheck.Status")
C_BOOLEAN:C305($isActivited)
$isActivited:=True:C214
Case of 
	: ($mChkStatus="demo")
		$url:="https://demo.membercheck.net"+$path
	: ($mChkStatus="app")
		$url:="https://app.membercheck.net"+$path
	Else 
		$isActivited:=False:C215
End case 

If ($isActivited)
	ARRAY TEXT:C222($headerName; 0)
	ARRAY TEXT:C222($headerValues; 0)
	
	APPEND TO ARRAY:C911($headerName; "api-key")
	APPEND TO ARRAY:C911($headerValues; getKeyValue("MemberCheck.APIKey"))
	
	APPEND TO ARRAY:C911($headerName; "Content-Type")
	APPEND TO ARRAY:C911($headerValues; "application/json")
	
	APPEND TO ARRAY:C911($headerName; "Accept")
	APPEND TO ARRAY:C911($headerValues; "application/json")
	
	C_OBJECT:C1216($response)
	C_REAL:C285($status)
	$status:=HTTP Request:C1158($httpMethod; $url; $body; $response; $headerName; $headerValues)
	
	//$doc:=Create document("";".json")
	//SEND PACKET($doc;JSON Stringify($result))
	//CLOSE DOCUMENT($doc)
	C_TEXT:C284($title; $message)
	If ($status>300)
		$title:=String:C10($status)+" HTTP Request Error"
		$message:=$response.message
		If (OB Is defined:C1231($body; "modelState"))
			$message:=$message+"\n"+JSON Stringify:C1217($response.modelState; *)
		End if 
		myAlert($message; $title)
	End if 
	
	
	$result:=New object:C1471
	$result.status:=$status
	$result.returned:=$response
Else 
	$result:=New object:C1471
	$result.status:=0
	$result.returned:=New object:C1471
End if 

$0:=$result
