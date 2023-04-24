//%attributes = {}
// For Querying bit.io database

C_OBJECT:C1216($result; $bodyObj; $headersObj)
C_TEXT:C284($RequestType; $1; $url; $2)
C_LONGINT:C283($status; gError)
C_BLOB:C604($response)

$result:=New object:C1471
$headersObj:=New object:C1471
$bodyObj:=New object:C1471

$RequestType:=HTTP POST method:K71:2
$url:="https://api.bit.io/v2beta/query"
$headersObj.Authorization:="Bearer v2_3txcC_M3P262z8GvFFCinVWXXYq68"
$headersObj["Content-Type"]:="application/json"

Case of 
	: (Count parameters:C259=2)
		$bodyObj.query_string:=$1
		$bodyObj.database_name:=$2
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
$result.response:=Convert to text:C1012($response; "UTF-8")
$result.headers:=$returnHeaders
If (gError=0)  // If ON ERR CALL was not called
	$result.message:="success"
Else 
	$result.message:="Error #"+String:C10(gError)+". There was a problem trying to reach URL: "+$url
End if 

$0:=$result

