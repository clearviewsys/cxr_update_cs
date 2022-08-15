//%attributes = {}

//https://www.polipayments.com/POLiLinkReport
//To get a transaction history of a single POLi Link created by the merchant:

//history will contain
If (False:C215)
	//$response.TransactionRefNo  //The transaction reference number of the transaction (unique POLi ID)
	//$response.BankReceiptNo  //The number issued by the customer's bank for a completed payment
	//$response.BankReceiptDateTime  //The date/time the transaction was completed
	//$response.Status  //The final status of the transaction (differs from the POLi Link Status)
	//$response.AmountPaid  //The amount paid for that transaction - zero if not completed
	//$response.CompletionTime  //The date/time the transaction was completed
	//$response.MerchantReference  //The MerchantReference specified when the POLiLink was created
	//$response.CustomerReference  //Data entered by the customer at the time of payment which uniquely identifies the customer and/or their payment
End if 


C_TEXT:C284($1; $poliLink)  //link that was returned with POLI_getLink

C_OBJECT:C1216($0; $return)

C_OBJECT:C1216($response)
C_LONGINT:C283($status)
C_TEXT:C284($currOnErr)

$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")

$poliLink:=POLI_getTokenFromLink($1)

$return:=New object:C1471
$return.success:=True:C214
$return.status:=0
$return.statusText:=""
$return.token:=$poliLink


ARRAY TEXT:C222($atHeaderNames; 0)
ARRAY TEXT:C222($atHeaderValues; 0)
POLI_setHeaderArrays(->$atHeaderNames; ->$atHeaderValues)


If (Choose:C955(getKeyValue("web.configuration.payments.poli.testmode"; "true")="true"; True:C214; False:C215))
	$status:=HTTP Get:C1157("https://publicapi.uat1.paywithpoli.com/api/POLiLink/Payments/"+$poliLink; $response; $atHeaderNames; $atHeaderValues)
Else 
	$status:=HTTP Get:C1157("https://publicapi.apac.paywithpoli.com/api/POLiLink/Payments/"+$poliLink; $response; $atHeaderNames; $atHeaderValues)
End if 

If ($status=200)
	$return.success:=True:C214
	$return.status:=1
	$return.statusText:=$response.Status  //this is caps per the Poli API
	$return.token:=$poliLink
	$return.history:=$response.Transactions
Else 
	$return.success:=False:C215
	$return.status:=$status
	$return.statusText:="HTTP response status code: "+String:C10($status)
	$return.token:=$poliLink
End if 

ON ERR CALL:C155($currOnErr)

$0:=$return