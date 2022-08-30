//%attributes = {}


C_POINTER:C301($1; $headerNames)
C_POINTER:C301($2; $headerValues)


C_TEXT:C284($contentType; $authCode; $currency)
C_BLOB:C604($xBlob)


$headerNames:=$1
$headerValues:=$2


$contentType:="application/json"

If (getKeyValue("web.configuration.payments.poli.testmode"; "true")="true")
	$authCode:=getKeyValue("web.configuration.payments.poli.authcode"; "T64010031:sK3$XGANDW!ms")  //test
Else 
	$authCode:=getKeyValue("web.configuration.payments.poli.authcode"; "SS64011036:kN8@9tkeTrv2w")
End if 
$currency:=getKeyValue("web.configuration.payments.poli.currencycode"; "NZD")

TEXT TO BLOB:C554($authCode; $xBlob; UTF8 text without length:K22:17)
BASE64 ENCODE:C895($xBlob; $authCode)  //VDY0MDEwMDMxOnNLMyRYR0FORFchbXM=    <--- Lotus

APPEND TO ARRAY:C911($headerNames->; "Content-Type")
APPEND TO ARRAY:C911($headerValues->; $contentType)
APPEND TO ARRAY:C911($headerNames->; "Accept")
APPEND TO ARRAY:C911($headerValues->; $contentType)
APPEND TO ARRAY:C911($headerNames->; "Authorization")
APPEND TO ARRAY:C911($headerValues->; "Basic "+$authCode)