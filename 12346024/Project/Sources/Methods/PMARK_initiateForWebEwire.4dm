//%attributes = {}


C_OBJECT:C1216($0; $status)

C_REAL:C285($amount)
C_BOOLEAN:C305($doRequest)
C_TEXT:C284($particular)

$status:=New object:C1471
$status.success:=False:C215

$amount:=0


Case of 
	: (OB Is defined:C1231([WebEWires:149]paymentInfo:35; "url")=False:C215)
		$doRequest:=True:C214
	: ([WebEWires:149]paymentInfo:35.url="")
		$doRequest:=True:C214
	Else 
		$doRequest:=False:C215
End case 

If ($doRequest)  // make sure we don't already have a token
	
	If ([WebEWires:149]paymentInfo:35.deliveryMethod="MG")
		$amount:=[WebEWires:149]fromAmount:3+[WebEWires:149]fromFee:6
	Else 
		$amount:=[WebEWires:149]fromAmount:3
	End if 
	
	$particular:=Substring:C12([WebEWires:149]fromParty:7[Info_LastName]+" sends "+String:C10([WebEWires:149]toAmount:10)+" "+[WebEWires:149]toCCY:11+" to "+[WebEWires:149]toParty:8[Info_LastName]\
		+" Via: "+getPaymentTypeFromCode([WebEWires:149]paymentInfo:35.deliveryMethod); 1; 50)
	//$particular:="myorder"
	$status:=PMARK_initiateTransaction(New object:C1471("particular"; $particular; "token_reference"; $particular; "amount"; String:C10($amount); "reference"; [WebEWires:149]WebEwireID:1))
	//"particular";Substring([WebEWires]fromParty[Info_FullName]+" sends "+String([WebEWires]toAmount)+" to "+[WebEWires]toParty[Info_FullName]+" Delivery: "+[WebEWires]paymentInfo.deliveryMethod;1;50)))
	//$status:=PMARK_initiateTransaction (New object("amount";"15.79";"reference";$ref;"notification_url";"http://test.lotusfx.com:8082/4DHOOK/PMARK/NUDGE";"particular";"my order is this"))
	
	Case of 
		: ($status.success)
			[WebEWires:149]paymentInfo:35.url:=$status.url
			[WebEWires:149]paymentInfo:35.transactionRefNo:=$status.reference
			[WebEWires:149]paymentInfo:35.gateway:="paymark"
			
		: ($status=Null:C1517)
			[WebEWires:149]paymentInfo:35.status:="Failure"
			[WebEWires:149]paymentInfo:35.statusText:="PMARK_initiateTransaction failed."
			
			$status:=New object:C1471
			$status.success:=False:C215
			$status.status:="Failure"
			$status.statusText:=[WebEWires:149]paymentInfo:35.statusText
		Else 
			[WebEWires:149]paymentInfo:35.status:=$status.status
			[WebEWires:149]paymentInfo:35.statusText:=$status.statusText
	End case 
	
End if 

$0:=$status