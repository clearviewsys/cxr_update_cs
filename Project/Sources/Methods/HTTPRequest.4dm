//%attributes = {}
// HTTP REQUEST LIBRARY
//Work with sending Content-Type "application/x-www-form-urlencoded" or "application/json" in body - Jan 19 2021
// @viktor

// Unit test is written @Viktor

C_OBJECT:C1216($result; $0; $bodyObj; $3; $headersObj; $4)
C_TEXT:C284($RequestType; $1; $url; $2)
C_LONGINT:C283($status; gError)
C_OBJECT:C1216($response)
$result:=New object:C1471

Case of 
	: (Count parameters:C259=2)
		$RequestType:=Uppercase:C13($1)
		$url:=$2
	: (Count parameters:C259=3)
		$RequestType:=Uppercase:C13($1)
		$url:=$2
		$bodyObj:=$3
	: (Count parameters:C259=4)
		$RequestType:=Uppercase:C13($1)
		$url:=$2
		$bodyObj:=$3
		$headersObj:=$4
	Else 
		// Invalid number of parameters
End case 




//--------------------------------------------
// Get Header Arrays from Obj
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
C_BOOLEAN:C305($hasContentType)
C_TEXT:C284($currContentType)
$hasContentType:=False:C215
OB GET PROPERTY NAMES:C1232($headersObj; $headerNames)
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($headerNames))
	If (Lowercase:C14($headerNames{$i})="content-type")
		$hasContentType:=True:C214
		$currContentType:=$headersObj[$headerNames{$i}]
	End if 
	APPEND TO ARRAY:C911($headerValues; $headersObj[$headerNames{$i}])
	
End for 
If ($hasContentType=False:C215)
	APPEND TO ARRAY:C911($headerNames; "Content-Type")
	APPEND TO ARRAY:C911($headerValues; "application/x-www-form-urlencoded")
	$currContentType:="application/x-www-form-urlencoded"
End if 
// -------------------------------------------

//--------------------------------------------
//Get Body string from object
C_TEXT:C284($body)
C_LONGINT:C283($k)
Case of 
	: (Lowercase:C14($currContentType)="application/x-www-form-urlencoded")
		ARRAY TEXT:C222($paramNames; 0)
		OB GET PROPERTY NAMES:C1232($bodyObj; $paramNames)
		For ($k; 1; Size of array:C274($paramNames))
			If ($k>1)
				$body:=$body+"&"
			End if 
			$body:=$body+$paramNames{$k}+"="+$bodyObj[$paramNames{$k}]
		End for 
		
	: (Lowercase:C14($currContentType)="application/json")
		$body:=JSON Stringify:C1217($bodyObj)
End case 
//--------------------------------------------

gError:=0
// Make HTTP Request
ON ERR CALL:C155("getJSONError")
$status:=HTTP Request:C1158($RequestType; $url; $body; $response; $headerNames; $headerValues)
ON ERR CALL:C155("")




// -------------------------------------------
// Turn Headers into an object to be returned
C_LONGINT:C283($j)
C_OBJECT:C1216($returnHeaders)
$returnHeaders:=New object:C1471
For ($j; 1; Size of array:C274($headerNames))
	$returnHeaders[$headerNames{$j}]:=$headerValues{$j}
End for 
// -------------------------------------------





$result.status:=$status
$result.response:=$response
$result.headers:=$returnHeaders
If (gError=0)  // If ON ERR CALL was not called
	$result.message:="success"
Else 
	$result.message:="Error #"+String:C10(gError)+". There was a problem trying to reach URL: "+$url
End if 
$0:=$result




