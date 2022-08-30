//%attributes = {}
// Unit test is written @Barclay
If (False:C215)
	//https://poliapi.apac.paywithpoli.com/api/v2/Transaction/Initiate
	
	// --- POSSIBLE PARAMETERS ---
	//REQUEST
	//Amount - The transaction amount the customer should be chargedDecimal.Value upto 2 decimal places.NumberYes10.50
	//CurrencyCode - The currency of the transaction
	//         Note:This must match the currency of your merchant account
	////        String/Text.Usually 3 charactersStringYesAUD
	//MerchantReference - Unique reference specified by the merchant for the transactionS-100 characters max. Alphanumeric characters and spaces
	//         Australian Merchants-Special characters: @-_=: ?./are allowed
	//         New Zealand Merchants-Special characters: @-_=: ?./will be accepted, but replaced with a space when entered into the bank field
	//         StringYesORDER123ABC
	//MerchantReferenceFormat - Used to specify a New Zealand reconciliation format.See NZReconciliation for more detailsString-Used for NZ reconciliation.
	//         50 characters maxStringNoSee NZ reconciliation
	//MerchantData - This field is for the merchant transaction referenceMerchant specifi-transaction.2000 charactersStringNoSee GETTransaction
	//MerchantHomepageURL - The complete merchant URL is displayed in the merchant inform.1000 characters maxStringYeshttp:  //my.online.shop
	//SuccessURL - The complete URL to redirect the customer to if the transaction is suc.If specified URL has single/multiple query strings then POLi will append transaction token to the query para.1000 characters maxStringYesSpecified URL: http:  //my.online.shop/successfullPayment.aspx ReturnedURL: http://my.online.shop/successfullPayment.aspx?token=[transactiontoken]
	//FailureURL - The complete URL to redirect the customer to if the transaction is not.If specified URL has single/multiple query strings then POLi will append transaction token to the query para.1000 characters maxStringNoSpecified URL: http:  //my.online.shop/FailedPayment.aspx ReturnedURL: http://my.online.shop/FailedPayment.aspx?token=[transactiontoken]
	//CancellationURL - The complete URL used to redirect the customer to if they cancel .Addstransaction token as query parameter if no query string in the URL.If specified URL has single/multiple query strings then POLi will append transaction token to the query para.1000 characters maxStringNoSpecified URL: http:  //my.online.shop/CancelledPayment.aspx ReturnedURL: http://my.online.shop/CancelledPayment.aspx?token=[transactiontoken]
	//NotificationURL - The complete URL where POLi will deliver the Nudge POST toPOLi wiÔ0;0Ô 
	//               Ensure your endpoint supports HTTP POST.
	//               1000 characters maxStringNohttp:  //my.online.shop/nudge.aspx
	//Timeout - The timeout for the transaction in seconds, which defaults to 900(15 minutes)Number of seconds before transaction times outNumberNo900
	//SelectedFICode - Used for pre-selecting banks in order to skip the POLi Landing pageString representing the FI the customer will pay withStringNo
	
	
	//RESPONSE
	
	//Success - A value indicating successBooleanBooleantrue or false
	//TransactionRefNo - The POLi ID is a reference to a POLi transaction.Thisis used in the reference field of the user bank transfer payment 
	//        and should be u.StringStringAunique 12 digit reference to a POLi transaction.
	//NavigateURL - The Navigate URL is the location that the user should be redirected t.It contains a transaction token which is an encrypted form of the TransactionRef.StringStringAvalid URL for the POLi landing page appended with a query string containing the .Example:Australia/New Zealand:https:  //txn.apac.paywithpoli.com/?token=[token]
	//ErrorCode - An error code, if there was one(O if none)IntegerNumberSee Error Codes
	//ErrorMessage - A string containing details about the errorStringStringSee Error Codes
	
End if 


C_OBJECT:C1216($1; $request)

C_OBJECT:C1216($0; $return)


C_LONGINT:C283($status; $expiryDays; $timeOut)
C_TEXT:C284($currency)
C_BOOLEAN:C305($isTesting)
C_TEXT:C284($currOnErr; $baseURL; $context)
C_OBJECT:C1216($return; $response)

$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")

$isTesting:=Choose:C955(getKeyValue("web.configuration.payments.poli.testmode"; "true")="true"; True:C214; False:C215)
$expiryDays:=Num:C11(getKeyValue("web.configuration.payments.poli.expirydays"; "1"))
$timeOut:=Num:C11(getKeyValue("web.configuration.payments.poli.timeout"; "1800"))
$currency:=getKeyValue("web.configuration.payments.poli.defaultccy"; "NZD")  //"NZD"
$baseURL:=getKeyValue("web.configuration.baseURL"; "https://127.0.0.1/")
$baseURL:=$baseURL+Choose:C955(Substring:C12($baseURL; Length:C16($baseURL); 1)="/"; ""; "/")
$context:="customers"


$return:=New object:C1471  //INITIALIZ
$return.success:=True:C214
$return.status:=0
$return.statusText:=""


If (Count parameters:C259>=1)
	$request:=$1
Else   //testing code
	If ($isTesting)
		$request:=New object:C1471
		
		OB SET:C1220($request; "Amount"; "1.75")  //required -- with decimals
		OB SET:C1220($request; "CurrencyCode"; "NZD")  // Optional - 3 chars - must match currency of merchant account AUD/NZD
		OB SET:C1220($request; "MerchantReference"; "CXR-MerchRef-3456789")
		OB SET:C1220($request; "MerchantHomepageURL"; $baseURL+$context)
		OB SET:C1220($request; "SuccessURL"; $baseURL+$context+"/poli-success")
		OB SET:C1220($request; "FailureURL"; $baseURL+$context+"/poli-failure")
		OB SET:C1220($request; "CancellationURL"; $baseURL+$context+"/poli-cancellation")
		OB SET:C1220($request; "NotificationURL"; $baseURL+$context+"/4DHOOK/POLI/NUDGE")  //listener on server
		
	Else 
		$return.success:=False:C215
		$return.status:=-9999
		$return.statusText:="Missing paramter object in $1"
	End if 
End if 


$response:=New object:C1471

//--------- MAKE SURE THE REQUIRED ELEMENTS ARE INCLUDED -------
If (True:C214)
	ARRAY TEXT:C222($aProperties; 0)
	OB GET PROPERTY NAMES:C1232($request; $aProperties)
	
	If (Choose:C955(Find in array:C230($aProperties; "Amount")=-1; True:C214; False:C215))  //Amount is not in the object
		If ($isTesting)
			OB SET:C1220($request; "Amount"; "1.99")
		Else 
			$return.success:=False:C215
			$return.status:=-1
			$return.statusText:="Missing Amount"
		End if 
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "CurrencyCode")=-1; True:C214; False:C215))  //CurrencyCode is not in the object
		OB SET:C1220($request; "CurrencyCode"; $currency)  //must match currency of merchant account AUD/NZD
	End if 
	
	If ($isTesting)
		OB SET:C1220($request; "CurrencyCode"; getKeyValue("web.configuration.payments.poli.defaultccy"; "NZD"))
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "Timeout")=-1; True:C214; False:C215))  //timeout is not in the object
		OB SET:C1220($request; "Timeout"; $timeOut)  //use keyvalue setting
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "MerchantReference")=-1; True:C214; False:C215))  //MerchantReference is not in the object
		If ($isTesting)
			OB SET:C1220($request; "MerchantReference"; "CXR-MerchRef-TEST-123456789")
		Else 
			$return.success:=False:C215
			$return.status:=-1
			$return.statusText:="Missing MerchantReference"
		End if 
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "MerchantHomepageURL")=-1; True:C214; False:C215))  //MerchantReference is not in the object
		If ($isTesting)
			OB SET:C1220($request; "MerchantHomepageURL"; $baseURL)
		Else 
			$return.success:=False:C215
			$return.status:=-1
			$return.statusText:="Missing MerchantHomepageURL"
		End if 
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "SuccessURL")=-1; True:C214; False:C215))  //MerchantReference is not in the object
		If ($isTesting)
			OB SET:C1220($request; "SuccessURL"; $baseURL+$context+"/poli-success")
		Else 
			$return.success:=False:C215
			$return.status:=-1
			$return.statusText:="Missing SuccessURL"
		End if 
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "FailureURL")=-1; True:C214; False:C215))  //MerchantReference is not in the object
		If ($isTesting)
			OB SET:C1220($request; "FailureURL"; $baseURL+$context+"/poli-failure")
		Else 
			$return.success:=False:C215
			$return.status:=-1
			$return.statusText:="Missing FailureURL"
		End if 
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "CancellationURL")=-1; True:C214; False:C215))  //MerchantReference is not in the object
		If ($isTesting)
			OB SET:C1220($request; "CancellationURL"; $baseURL+$context+"/poli-cancellation")
		Else 
			$return.success:=False:C215
			$return.status:=-1
			$return.statusText:="Missing CancellationURL"
		End if 
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "NotificationURL")=-1; True:C214; False:C215))  //URL where POLi will deliver the Nudge POST toPOLi
		If ($isTesting)
			OB SET:C1220($request; "NotificationURL"; $baseURL+$context+"/4DHOOK/POLI/NUDGE")
		Else 
			$return.success:=False:C215
			$return.status:=-1
			$return.statusText:="Missing NotificationURL"
		End if 
	End if 
	
End if 

//--- DO WE NEED TO TEST ALL VALUES SENT IN? OR LET THE API RETURN THE ERROR? ----

If ($return.success)
	ARRAY TEXT:C222($atHeaderNames; 0)
	ARRAY TEXT:C222($atHeaderValues; 0)
	POLI_setHeaderArrays(->$atHeaderNames; ->$atHeaderValues)
	
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; 120)
	
	If ($isTesting)  //testing URL
		$status:=HTTP Request:C1158(HTTP POST method:K71:2; "https://poliapi.uat1.paywithpoli.com/api/v2/Transaction/Initiate"; $request; $response; $atHeaderNames; $atHeaderValues)
	Else 
		$status:=HTTP Request:C1158(HTTP POST method:K71:2; "https://poliapi.apac.paywithpoli.com/api/v2/Transaction/Initiate"; $request; $response; $atHeaderNames; $atHeaderValues)
	End if 
	
Else 
	$status:=-1  //ERROR WITH REQUEST PRIOR TO ATTEMPTING A POLIPAYLINK
End if 


Case of 
	: ($status=-1)  //error with parameters
		//just pass the $return object back
		WAPI_Log(Current method name:C684; $return.statusText)
		
	: ($status=200)  //all REQUEST HAS RETURNED A RESPONSE FROM THE API
		
		If ($response.Success)  //we have a link
			$return.success:=True:C214
			$return.status:=$response.ErrorCode
			$return.statusText:=$response.ErrorMessage
			$return.reference:=$response.TransactionRefNo
			$return.url:=$response.NavigateURL  //ie. https://poli.to/wsWnx
			
		Else   //error from the API
			$return.success:=False:C215
			$return.status:=$response.ErrorCode
			$return.statusText:=$response.ErrorMessage
			
			WAPI_Log(Current method name:C684; String:C10($return.status)+": "+$return.statusText)
		End if 
		
	Else 
		//ERROR WITH REQUEST
		$return.success:=False:C215
		$return.status:=$status
		$return.statusText:="HTTP response status code: "+String:C10($status)+" "+$response.message
		
		WAPI_Log(Current method name:C684; $return.statusText)
End case 

ON ERR CALL:C155($currOnErr)
$0:=$return