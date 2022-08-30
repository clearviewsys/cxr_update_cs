//%attributes = {}

//https://www.polipayments.com/POLiLinkStatus

//As part of automating your integration with POLi Link API,
// you can periodically query the status of a POLi Link to determine if it has been fully paid.

C_TEXT:C284($1; $poliLink)  //link that was returned with POLI_getLink

C_OBJECT:C1216($0; $return)

C_LONGINT:C283($status)
C_TEXT:C284($response)
C_BOOLEAN:C305($isTesting)
C_TEXT:C284($currOnErr)

$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")

$poliLink:=$1

$return:=New object:C1471
$return.success:=True:C214
$return.status:=0
$return.statusText:=""

$isTesting:=Choose:C955(getKeyValue("web.configuration.payments.poli.testmode"; "true")="true"; True:C214; False:C215)

$poliLink:=POLI_getTokenFromLink($poliLink)

ARRAY TEXT:C222($atHeaderNames; 0)
ARRAY TEXT:C222($atHeaderValues; 0)
POLI_setHeaderArrays(->$atHeaderNames; ->$atHeaderValues)


If ($isTesting)
	$status:=HTTP Get:C1157("https://poliapi.uat1.paywithpoli.com/api/POLiLink/Status/"+$poliLink; $response; $atHeaderNames; $atHeaderValues)
Else 
	$status:=HTTP Get:C1157("https://publicapi.apac.paywithpoli.com/api/POLiLink/Status/"+$poliLink; $response; $atHeaderNames; $atHeaderValues)
End if 


If ($status=200)
	$response:=Replace string:C233($response; Char:C90(Double quote:K15:41); "")
	
	//$return.statusnumbers are our internal codes for the response
	
	Case of 
		: ($response="Unused")  //The customer has never clicked on the link to perform a transactions
			$return.status:=1
			$return.statusText:=$response
			
		: ($response="Activated")  //The customer has attempted a transaction with the link but didn't complete
			$return.status:=2
			$return.statusText:=$response
			
		: ($response="PartPaid")  //The POLi Link permits partial payments and the customer has paid towards the POLi Link but there is still an amount owing
			$return.status:=3
			$return.statusText:=$response
			
		: ($response="Future")  //The customer has performed a transaction where the payment is scheduled to occur automatically on the future date specified when the POLi Link was created
			$return.status:=4
			$return.statusText:=$response
			
		: ($response="Completed")  //The full amount has been paid
			$return.status:=5
			$return.statusText:=$response
			
		Else 
			$return.success:=False:C215
			$return.status:=-9999  //unknown
			$return.statusText:=$response
	End case 
	
Else   //ERROR WITH REQUEST
	$return.success:=False:C215
	$return.status:=$status
	$return.statusText:="HTTP response status code: "+String:C10($status)
End if 

ON ERR CALL:C155($currOnErr)

$0:=$return