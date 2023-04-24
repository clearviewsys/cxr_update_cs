//%attributes = {}
// ws_getConversionRate_S2
// get the currency rate from our Clear View Cloud Server (cloud.clearviewsys.net)  using Rest

//author: Amir
//18th Nov 2019
//ws_REST_getConversionRate(fromCurrency;toCurrency;->resultRate) -> error
//returns 0 if successful
//documentation of CXRate Azure web service: https://docs.google.com/document/d/1-N9Y-5SVsDSnlvkOoxeHQPNheRgqwZbNolhFv6z0kdY/

C_LONGINT:C283($error; $0)
C_TEXT:C284($fromCurrency; $toCurrency; $1; $2)
C_TEXT:C284(encodedClientKey2; encodedClientCode2)
C_POINTER:C301($ratePtr; $3)

C_LONGINT:C283($iTries)

$fromCurrency:=$1
$toCurrency:=$2
$ratePtr:=$3

If ((encodedClientKey2="") | (encodedClientCode2=""))
	encodedClientKey2:=replaceUnsafeURLCharacters(<>clientKey2)
	encodedClientCode2:=replaceUnsafeURLCharacters(<>clientCode2)
End if 


C_TEXT:C284($url; $domain)
$domain:="https://cloud.clearviewsys.net/cxrate/json/"

$url:=$domain+"getRate?clientcode="+encodedClientCode2+"&clientkey="+encodedClientKey2+"&from="+$fromCurrency+"&to="+$toCurrency
C_TEXT:C284($response; $content)
C_LONGINT:C283($httpStatus)

HTTP SET OPTION:C1160(HTTP timeout:K71:10; <>webTimeOut)  //time out in 5 seconds
setErrorTrap(Current method name:C684; "Error connecting to CXRate REST cloud service.")

$iTries:=0
Repeat 
	$iTries:=$iTries+1
	
	$httpStatus:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $content; $response)
	
	If ($httpStatus=200)
	Else 
		DELAY PROCESS:C323(Current process:C322; 10)
	End if 
	
Until (($httpStatus=200) | ($iTries>=5))

//$response="-1" means invalid user (authentication/authorization/licensing error)
//$response="-2" means invalid currency code (or it is not supported)
//$response="-3" means server error (due to any network/database error)
//$response="0"  means rate is not available

If (($response#"-1") & ($response#"-2") & ($response#"-3") & ($response#"0") & ($httpStatus=200))
	$ratePtr->:=Num:C11($response; ".")
Else 
	$error:=1
End if 
$0:=$error
endErrorTrap
