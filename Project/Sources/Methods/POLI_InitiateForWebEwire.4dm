//%attributes = {}

// assumes current record - webewires is in read write and loaded
// it is up to the calling method to save the record

C_OBJECT:C1216($0; $status)


C_OBJECT:C1216($request; $return)
C_TEXT:C284($baseURL; $context; $particular)
C_BOOLEAN:C305($doRequest)


$status:=New object:C1471
$status.success:=False:C215

Case of 
	: (OB Is defined:C1231([WebEWires:149]paymentInfo:35; "poliToken")=False:C215)
		$doRequest:=True:C214
	: ([WebEWires:149]paymentInfo:35.poliToken="")
		$doRequest:=True:C214
	Else 
		$doRequest:=False:C215
End case 

If ($doRequest)  // make sure we don't already have a token
	
	$request:=New object:C1471
	If ([WebEWires:149]paymentInfo:35.deliveryMethod="MG")  // moneygram
		$request.Amount:=[WebEWires:149]fromAmount:3+[WebEWires:149]fromFee:6
	Else 
		$request.Amount:=[WebEWires:149]fromAmount:3
	End if 
	$request.MerchantReference:=[WebEWires:149]WebEwireID:1
	$particular:=Substring:C12([WebEWires:149]fromParty:7[Info_LastName]+" sends "+String:C10([WebEWires:149]toAmount:10)+" "+[WebEWires:149]toCCY:11+" to "+[WebEWires:149]toParty:8[Info_LastName]\
		+" Via: "+getPaymentTypeFromCode([WebEWires:149]paymentInfo:35.deliveryMethod); 1; 50)
	$request.MerchantData:=$particular  //"Send: "+String([WebEWires]toAmount;"###,###,##0.00")+" "+[WebEWires]toCCY+" to "+[WebEWires]toParty.fullName
	$request.CurrencyCode:=[WebEWires:149]fromCCY:5
	
	
	$baseURL:=getKeyValue("web.configuration.baseURL"; "https://127.0.0.1/")
	$baseURL:=$baseURL+Choose:C955(Substring:C12($baseURL; Length:C16($baseURL); 1)="/"; ""; "/")
	$context:="customers"
	
	OB SET:C1220($request; "MerchantHomepageURL"; $baseURL+$context)
	OB SET:C1220($request; "SuccessURL"; $baseURL+$context+"/poli-success")
	OB SET:C1220($request; "FailureURL"; $baseURL+$context+"/poli-failure")
	OB SET:C1220($request; "CancellationURL"; $baseURL+$context+"/poli-cancellation")
	OB SET:C1220($request; "NotificationURL"; $baseURL+$context+"/4DHOOK/POLI/NUDGE")  //listener on server
	
	If (OB Is defined:C1231([WebEWires:149]paymentInfo:35))
	Else 
		[WebEWires:149]paymentInfo:35:=New object:C1471
	End if 
	
	$return:=POLI_initiateTransaction($request)
	
	If ($return.success)
		[WebEWires:149]paymentInfo:35.url:=$return.url  // generic for additional gateways
		[WebEWires:149]paymentInfo:35.transactionRefNo:=$return.reference
		[WebEWires:149]paymentInfo:35.amountPaid:=[WebEWires:149]fromAmount:3
		[WebEWires:149]paymentInfo:35.gateway:="polipayapi"
		
		[WebEWires:149]paymentInfo:35.poliLink:=$return.url
		[WebEWires:149]paymentInfo:35.poliToken:=POLI_getTokenFromLink($return.url)
		
		
		//[WebEWires]paymentInfo.gateway:="polipayapi"
		//[WebEWires]paymentInfo.deliveryMethod:=
		//[WebEWires]paymentInfo.reference:=$return.reference  // generic for additional gateways
		
		$status.success:=True:C214
	Else 
		[WebEWires:149]paymentInfo:35.status:=$return.status
		[WebEWires:149]paymentInfo:35.statusText:=$return.statusText
		
		$status.success:=False:C215
		$status.statusText:="initiate transaction with Poli failed."
		$status.status:=-1
	End if 
	
Else 
	$status.success:=True:C214  // already have a token just pass it back
	$status.statusText:="Existing token found."
	$status.status:=0
End if 

$0:=$status