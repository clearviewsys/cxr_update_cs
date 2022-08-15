//%attributes = {}
// Unit test is written @Barclay
If (False:C215)
	//https://www.polipayments.com/POLiLink
	// --- POSSIBLE PARAMETERS ---
	//OB SET($request;"LinkType";"0")  // Optional -- 0=simple, 1=variable, 3=discounted
	//OB SET($request;"Amount";"1.2")  //required -- with decimals
	//OB SET($request;"CurrencyCode";"NZD")  // Optional - 3 chars - must match currency of merchant account AUD/NZD
	//OB SET($request;"MerchantData";"MyRef100")  //Optional - < 2000 chars
	//OB SET($request;"MerchantReference";"web12345678")  //Required - < 100 chars -- 
	//OB SET($request;"MerchantReferenceFormat";"1")  // value b/n 1 and 4` Optional - string b/n 1 and 4
	//OB SET($request;"ConfirmationEmail";"false")  //Optional - true or false - is merchant will receive an email when a POLI link trans is complete
	//OB SET($request;"AllowCustomerReference";"false")  // Optional - true or false - if customer can enter info that uniqueily identifies the customer or the payment during trans
	//OB SET($request;"LinkExpiry";"20201-01-31 16:00:00+11")  //Optional  - datetime as string - future date where POLI can't be used
	//OB SET($request;"MultiPayment";"false")  //Optional - boolean - if POLI link can be used time and time again to make payments
	//OB SET($request;"DueDate";"2021-01-31")  //Optional - date as string - future date that a paymen t can be scheduled for
	//OB SET($request;"AllowPartialPayments";"false")  //Optional - boolean - if the customer can pay the full amount over multiple transactions
	//OB SET($request;"AllowOverPayment";"false")  //Optional - boolean - if customer can pay more than the amount specified
	//OB SET($request;"Schedule";"2018-03-28=14.00|2018-04-29=12.00")  //Optional - string -- pipe delimited set of rules that spec a percentage discount if paid before specified date
	//OB SET($request;"ViaEmail";"false")  //Optional - boolean - if customer received an email from POLI on behalf of merchant outline the details of the Poli link payment - RecipientName and RecipientEmail required
	//OB SET($request;"RecipientName";"false")  //Required - boolean - display the name of customer receiving the POLILink email
	//OB SET($request;"RecipientEmail";"false")  //Required - string - email address of the recipient email 
End if 


C_OBJECT:C1216($1; $request)

C_OBJECT:C1216($0; $return)


C_LONGINT:C283($status; $expiryDays)
C_TEXT:C284($response; $currency)
C_BOOLEAN:C305($isTesting)
C_TEXT:C284($currOnErr)

$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")

$isTesting:=Choose:C955(getKeyValue("web.configuration.payments.poli.testmode"; "true")="true"; True:C214; False:C215)
$expiryDays:=Num:C11(getKeyValue("web.configuration.payments.poli.expirydays"; "1"))

$return:=New object:C1471  //INITIALIZ
$return.success:=True:C214
$return.status:=0
$return.statusText:=""


If (Count parameters:C259>=1)
	$request:=$1
Else   //testing code
	If ($isTesting)
		$request:=New object:C1471
		OB SET:C1220($request; "LinkType"; "0")  // Optional -- 0=simple, 1=variable, 3=discounted
		OB SET:C1220($request; "Amount"; "1.75")  //required -- with decimals
		OB SET:C1220($request; "RecipientName"; "false")  //Required - boolean - display the name of customer receiving the POLILink email
		OB SET:C1220($request; "RecipientEmail"; "false")  //Required - string - email address of the recipient email 
		OB SET:C1220($request; "MerchantReference"; "CXR-MerchRef-123456789")  //Required - < 100 chars -- 
		
		OB SET:C1220($request; "CurrencyCode"; "NZD")  // Optional - 3 chars - must match currency of merchant account AUD/NZD
		OB SET:C1220($request; "MerchantData"; "CXR Test Merch Data")  //Optional - < 2000 chars
		OB SET:C1220($request; "ConfirmationEmail"; "false")  //Optional - true or false - is merchant will receive an email when a POLI link trans is complete
		OB SET:C1220($request; "ViaEmail"; "false")  //Optional - boolean - if customer received an email from POLI on behalf of merchant outline the details of the Poli link payment - RecipientName and RecipientEmail required
		
		OB SET:C1220($request; "LinkExpiry"; String:C10(Add to date:C393(Current date:C33; 0; 0; $expiryDays); ISO date GMT:K1:10; Current time:C178))  //"2021-01-31 16:00:00+11")  //Optional  - datetime as string - future date where POLI can't be used
	Else 
		$return.success:=False:C215
		$return.status:=-9999
		$return.statusText:="Missing paramter object in $1"
	End if 
End if 




$response:=""


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
	
	If (Choose:C955(Find in array:C230($aProperties; "RecipientName")=-1; True:C214; False:C215))  //RecipientName is not in the object
		OB SET:C1220($request; "RecipientName"; "false")  //default to false
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "RecipientEmail")=-1; True:C214; False:C215))  //RecipientEmail is not in the object
		OB SET:C1220($request; "RecipientEmail"; "false")  //default to false
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
End if 

//--- DO WE NEED TO TEST ALL VALUES SENT IN? OR LET THE API RETURN THE ERROR? ----

If ($return.success)
	ARRAY TEXT:C222($atHeaderNames; 0)
	ARRAY TEXT:C222($atHeaderValues; 0)
	POLI_setHeaderArrays(->$atHeaderNames; ->$atHeaderValues)
	
	If ($isTesting)  //testing URL
		$status:=HTTP Request:C1158(HTTP POST method:K71:2; "https://poliapi.uat1.paywithpoli.com/api/POLiLink/Create"; $request; $response; $atHeaderNames; $atHeaderValues)
	Else 
		$status:=HTTP Request:C1158(HTTP POST method:K71:2; "https://poliapi.apac.paywithpoli.com/api/POLiLink/Create"; $request; $response; $atHeaderNames; $atHeaderValues)
	End if 
	
Else 
	$status:=-1  //ERROR WITH REQUEST PRIOR TO ATTEMPTING A POLIPAYLINK
End if 


Case of 
	: ($status=-1)  //error with parameters
		//just pass the $return object back
		
	: ($status=200)  //all REQUEST HAS RETURNED A RESPONSE FROM THE API
		$response:=Replace string:C233($response; Char:C90(Double quote:K15:41); "")
		
		If ($response="https://@")  //we have a link
			$return.success:=True:C214
			$return.status:=1  // ie. OK=1 ...... maybe other???
			$return.statusText:=$response  //ie. https://poli.to/wsWnx
			
		Else   //error from the API
			$return.success:=False:C215
			$return.status:=Num:C11($response)
			$return.statusText:=POLI_getErrText(Num:C11($response))
		End if 
		
	Else 
		//ERROR WITH REQUEST
		$return.success:=False:C215
		$return.status:=$status
		$return.statusText:="HTTP response status code: "+String:C10($status)
End case 

ON ERR CALL:C155($currOnErr)
$0:=$return