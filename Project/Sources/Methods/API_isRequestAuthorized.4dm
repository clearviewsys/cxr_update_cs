//%attributes = {}


C_OBJECT:C1216($0; $status)

C_LONGINT:C283($elem; $pos)
C_BOOLEAN:C305($isHostValid; $isKeyValid; $isUserValid)
C_TEXT:C284($apiUser; $encoded; $decoded)

ARRAY TEXT:C222($aHeaderNames; 0)
ARRAY TEXT:C222($aHeaderValues; 0)
WEB GET HTTP HEADER:C697($aHeaderNames; $aHeaderValues)


$status:=New object:C1471("success"; False:C215; "status"; -1; "statusText"; "")
//$isHostValid:=False
$isKeyValid:=False:C215

//$apiHost:=getKeyValue("api.host"; "CAB")

//$elem:=Find in array($aHeaderNames; "Cxr-host")
//If ($elem>0)
//$isHostValid:=Choose($aHeaderValues{$elem}=$apiHost; True; False)
//End if 

$elem:=Find in array:C230($aHeaderNames; "Authorization")  //user:apikey that is base64 encoded
If ($elem>0)
	$encoded:=Replace string:C233($aHeaderValues{$elem}; "Basic "; "")
	BASE64 DECODE:C896($encoded; $decoded)
	
	$pos:=Position:C15(":"; $decoded)
	If ($pos>0)
		$apiUser:=Substring:C12($decoded; 1; $pos-1)
		
		If (getKeyValue("api.token."+$apiUser; "123456789")=Substring:C12($decoded; $pos+1))
			$isKeyValid:=True:C214
		Else 
			$isKeyValid:=False:C215
		End if 
		
		//$isKeyValid:=Choose($aHeaderValues{$elem}="Basic "+getKeyValue("api.token."+$apiUser; "123456789"); True; False)
	End if 
End if 



Case of 
	: ($isKeyValid)
		$status.success:=True:C214
		$status.status:=200
		$status.statusText:=""
		
		//: ($isHostValid=False)
		//$status.status:=401
		//$status.statusText:="Invalid Host"
		
	: ($isKeyValid=False:C215)
		$status.status:=401
		$status.statusText:="Invalid Authorization"
		
		
	Else 
		$status.status:=401
		$status.statusText:="UKNOWN VALIDATION HEADERS"
End case 



$0:=$status