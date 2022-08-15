//%attributes = {}
// clears cookies in web area browser

C_TEXT:C284($1; $webArea)
C_COLLECTION:C1488($2; $cookies)  // cookies to clear
C_TEXT:C284($oneCookie; $result; $js)

$webArea:=$1
$cookies:=$2

For each ($oneCookie; $cookies)
	
	$js:="document.cookie="+Char:C90(Double quote:K15:41)+$oneCookie+"=;expires=Thu, 01 Jan 1970 00:00:00 GMT"+Char:C90(Double quote:K15:41)
	
	$result:=WA Evaluate JavaScript:C1029(*; $webArea; $js)
	
End for each 

