//%attributes = {}
//https://www.polipayments.com/POLiLinkReport

//Provides a full list of POLi Links created by the merchant. 
//It is effectively the same as the Status command but returns a batch of statuses 
//and other basic information about the POLi Link

// Unit test is written @Barclay


C_OBJECT:C1216($0; $return)

//C_OBJECT($response)
C_LONGINT:C283($status)
C_TEXT:C284($response)
C_TEXT:C284($currOnErr)

$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")

$response:=""

$return:=New object:C1471
$return.success:=True:C214
$return.status:=0
$return.statusText:=""


ARRAY TEXT:C222($atHeaderNames; 0)
ARRAY TEXT:C222($atHeaderValues; 0)
POLI_setHeaderArrays(->$atHeaderNames; ->$atHeaderValues)


If (Choose:C955(getKeyValue("web.configuration.payments.poli.testmode"; "true")="true"; True:C214; False:C215))
	$status:=HTTP Get:C1157("https://publicapi.uat1.paywithpoli.com/api/POLiLink/List/"; $response; $atHeaderNames; $atHeaderValues)
Else 
	$status:=HTTP Get:C1157("https://publicapi.apac.paywithpoli.com/api/POLiLink/List/"; $response; $atHeaderNames; $atHeaderValues)
End if 

If ($status=200)
	$return.success:=True:C214
	$return.status:=1
	$return.list:=JSON Parse:C1218($response)
	$return.statusText:="Found: "+String:C10($return.list.length)
Else 
	$return.success:=False:C215
	$return.status:=$status
	$return.statusText:="HTTP response status code: "+String:C10($status)
End if 

ON ERR CALL:C155($currOnErr)

$0:=$return