//%attributes = {}
// http://docs.dev.paymark.nz/oe/

//http://docs.dev.paymark.nz/click/



// REQUEST OPTIONS
//Name     Description     Required     Type     Length
//username - Your Paymark Click Client ID.RequiredString50
//password - Your Paymark Click API Password.RequiredString50
//account_id - Your Paymark Click Account ID.RequiredIntegerN/A
//cmd - Defines the Web Payments integration service to use.Always use “_xclick” for a standard payment request.RequiredStringN/A
//amount - The transaction amount in NZD.Must be a positive value(more than zero)for purchase or authorisation requests.Ignored(and may be omitted)for “status check” requests.Ignored(but must be provided)for “tokenise” requests.RequiredDecimalN/A
//reference - Merchant defined value stored with the transaction.For Merchants accepting cards and Online EFTPOS, this should be a 12 character a.This will appear on the Account Holder’s bank statement and is truncated at 12.OptionalString50
//particular - Merchant defined value stored with the transaction.Allowed: alphanumeric, spaces, special characters @#’ & " ; . \\ / ! : , ? [ ] ( ) - _OptionalString50"
//return_url - The URL that the Cardholder/Account Holder will be sent to on completion of the payment.This must be a publicly accessible URL.Note: While this field is optional, this should be treated as required when the (see Two Return Options section)to ensure the Customer is returned to the Merchant web site.OptionalString1024
//notification_url - Additional URL where the transaction response will be sent to.This must be a publicly accessible URL.OptionalString1024
//display_customer_email - 0 or 1 as to whether to display the customer email receipt.
//           0=hide(default), 
//          1=display.OptionalIntegerN/A
//store_payment_token - Determines if the Customer’s payment method will be stored(tokenised)when the transaction is successful.
//           0=do not display option to store payment method(default), 
//          1=display option to store payment method for future use, 
//           2=store payment method without asking Customer(Customer must have opted into storing the payment method on the Merchant’s web).If type is set to “tokenise”, the store_payment_token parameter will be igno.OptionalIntegerN/A
//token_reference - Merchant defined reference associated with the stored payment met(or card token).
//.         Allowed: alphanumeric, spaces, special characters @#’" ; . \\ / ! : , ? [ ] ( ) - _OptionalString50"


//Optional
//type - Type of transaction requested, “purchase”, “authorisation” or “sta.
//          Should be included if not using the account’s(account_id)default transaction type.
//           Contact Paymark to confirm the default setting for this account_id.Purchase is used to make a payment.
//           Authorisation validates card details and holds funds on the card.Status check validates card details but does not 
//           hold any funds on the card;this is recommended for storing a card for future charges.
//          A fourth option, “tokenise” is also available, however this does not validat.
//           Contact Paymark to confirm if your Acquiring Bank supports status checks.OptionalStringN/A
//merchant_token - 0 or 1 as to whether a marketing token should be generated and ret.
//          0=do not generate a marketing token(default), 
//          1=generate and return marketing token.Note: If 1 is used, it is expected the Cardholder has opted in to creating a mar.OptionalIntegerN/A
//transaction_source - “MOTO” or “INTERNET” to indicate the source of the tra.
//          Default value is “INTERNET”.OptionalStringN/A
//button_label - Customise the text used on the “MAKE PAYMENT” button. Text will always be displayed in capitals. 
//         Allowed: alphanumeric, spaces, special characters $ , - ’ ! ? . #OptionalString20

// RETURN
//Name - DescriptionTypeLength
//TransactionId - Paymark Click defined unique transaction ID.String8
//Type - Transaction type(PURCHASE, AUTHORISATION, STATUS_CHECK, OE_PAYMENT, TOKENISE).String50
//AccountId - The Paymark Click Account ID used for processing the transaction.Integer8
//Status - Status of the transaction.
//.        0=UNKNOWN, 
//.       1=SUCCESSFUL, 
//.        2=DECLINED, 
//.        3=BLOCKED, 
//.        4=FAILED, 
//.        5=INPROGRESS, 
//.         6=CANCELLED.String50
//TransactionDate - Date and time when the transaction was processed.DatetimeN/A
//BatchNumber - Content of this data can vary based on type of transaction.Currently when this contains a value, it is a string representing the “estimat.String100
//ReceiptNumber - Paymark Click defined unique receipt ID.Integer8
//Amount - Amount of transaction in NZD, in the format 1.23.Decimal20
//Reference - Reference used for the transaction, as defined by the Merchant.String100
//Particular - Particulars used for the transaction, as defined by the Merchant.String100
//CardStored - When store_payment_token, store_card or store_card_without_input were .False=not stored, true=stored.Will always be false for Online EFTPOS payments, even when store_payment_token h.Boolean10
//ErrorCode - The error code indicating the type of error that occurred.See Response Codes and Messages for a full listing of error codes.String4
//ErrorMessage - The error message explaining what the error means.See Response Codes and Messages for a full listing of error codes.String510
//PaymentToken - The token of the newly stored payment method.Only available if the store_payment_token variable was set to 1 or 2, and the Cu.
//     Note: No token is created if the Customer pays using:
//     *Online EFTPOS and the Merchant is not enabled for Online EFTPOS Autopay.*Google Pay.String100

//PaymentTokenStatus - The status of the token request.The status is provided regardless of whether the token was created or not, so in.
//     SUCCESS=payment token has been created(and PaymentToken will contain the token ID).
//     MERCHANT_NOT_ENABLED=Customer selected a payment method for which the Merchant may not create tokens,.
//     USER_DECLINED=May appear when store_payment_token variable was set to 1.If Customer has paid using Online EFTPOS, and Customer has not selected Save OE =USER_DECLINED and there is no PaymentToken.Note: If Customer has paid using a card, and Customer has not selected Save Card.
//     ERROR=If (transaction)status=DECLINED, this means the Customer declined the Online EFTPOS payment.Or if there is another(transaction)status, this is an undefined issue when attempting to create the token.Contact Paymark for support.
//     PROCESSING=awaiting Customer action for an Online EFTPOS payment.String100
//TokenReference - Merchant defined reference associated with the stored payment meth(or card token).Present if the Customer paid using a card.String50

//The following table shows output fields that may also be present for a card paym.

//AuthCode - Authorisation code returned by the Bank for this transaction.String100
//CardType - The card type used for this transaction(MASTERCARD, VISA, AMERICAN_EXPRESS, QCARD).String50
//CardNumber - Masked card number showing first 6 and last 4 digits of the card.String100
//CardExpiry - Expiry date of the card, in the format MMYY.String100
//CardHolder - The Cardholder name entered into the Paymark Click hosted web payment .String100
//MerchantToken - The marketing token registered with Paymark for the card used for t.Only available if the merchant_token variable was set to 1.String100
//CardToken - The token of the newly stored payment method, if the Customer paid usin.Only available if the store_payment_token variable was set to 1 or 2, or store_c/store_card_without_input was set to 1, and the Customer chose to store their pay.String100
//AcquirerResponseCode - Response code from the acquirer to indicate the status and e.String6


C_OBJECT:C1216($1; $request)  // have to have: amount and reference

C_OBJECT:C1216($0; $return)


C_TEXT:C284($response; $encodedRequest)
C_TEXT:C284($value; $ref; $root; $currOnErr; $baseURL; $context)
C_LONGINT:C283($status; $i; $iPos)
C_BOOLEAN:C305($isTesting)


$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")



$baseURL:=getKeyValue("web.configuration.baseURL"; "http://test.lotusfx.com:8082/")
$baseURL:=$baseURL+Choose:C955(Substring:C12($baseURL; Length:C16($baseURL); 1)="/"; ""; "/")
$context:="customers"


$return:=New object:C1471  //INITIALIZ
$return.success:=True:C214
$return.status:=0
$return.statusText:=""

If (Count parameters:C259>=1)
	$request:=$1
	
	ARRAY TEXT:C222($aProperties; 0)
	OB GET PROPERTY NAMES:C1232($request; $aProperties)
	
	If (Choose:C955(Find in array:C230($aProperties; "amount")=-1; True:C214; False:C215))  //Amount is not in the object
		$return.success:=False:C215
		$return.status:=-1
		$return.statusText:="Missing Amount"
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "reference")=-1; True:C214; False:C215))  //
		$return.success:=False:C215
		$return.status:=-1
		$return.statusText:="Missing Reference"
	End if 
	
	//If (Choose(Find in array($aProperties;"particular")=-1;True;False))  //
	//OB SET($request;"particular";"CXR-particular")  //
	//End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "return_url")=-1; True:C214; False:C215))  //
		OB SET:C1220($request; "return_url"; $baseURL+$context+"/paymark-return?reference="+$request.reference)
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "notification_url")=-1; True:C214; False:C215))  //URL where POLi will deliver the Nudge POST toPOLi)
		OB SET:C1220($request; "notification_url"; $baseURL+$context+"/4DHOOK/PAYMARK/NUDGE")
	End if 
	
	If (Choose:C955(Find in array:C230($aProperties; "button_label")=-1; True:C214; False:C215))
		OB SET:C1220($request; "button_label"; getKeyValue("web.configuration.payments.paymark.buttonlabel"; "Pay Now"))
	End if 
	
	//OB SET($request;"display_customer_email";"1")
	//OB SET($request;"store_card";"0")
	//OB SET($request;"store_payment_token";"0")
	//OB SET($request;"token_reference";"[webewires]webewireid")
	//OB SET($request;"type";"purchase")
	//OB SET($request;"merchant_token";"0")
	
	If (True:C214)  //system settings
		OB SET:C1220($request; "cmd"; "_xclick")  //required
		OB SET:C1220($request; "transaction_source"; "INTERNET")
		
		$isTesting:=Choose:C955(getKeyValue("web.configuration.payments.paymark.testmode"; "true")="true"; True:C214; False:C215)
		If ($isTesting)
			OB SET:C1220($request; "username"; getKeyValue("web.configuration.payments.paymark.username"; "109955"))  //test
			OB SET:C1220($request; "password"; getKeyValue("web.configuration.payments.paymark.password"; "aeX0PNoFKU02wua6"))
			OB SET:C1220($request; "account_id"; getKeyValue("web.configuration.payments.paymark.accountid"; "631477"))
		Else 
			OB SET:C1220($request; "username"; getKeyValue("web.configuration.payments.paymark.username"; "109955"))  //test
			OB SET:C1220($request; "password"; getKeyValue("web.configuration.payments.paymark.password"; "aeX0PNoFKU02wua6"))
			OB SET:C1220($request; "account_id"; getKeyValue("web.configuration.payments.paymark.accountid"; "631477"))
		End if 
		
	End if 
	
Else 
	$request:=New object:C1471
	
	OB SET:C1220($request; "cmd"; "_xclick")  //required
	OB SET:C1220($request; "username"; "109955")  //required
	OB SET:C1220($request; "password"; "aeX0PNoFKU02wua6")  //required
	OB SET:C1220($request; "account_id"; "631477")  //required
	
	OB SET:C1220($request; "amount"; "1.05")  //required -- with decimals
	OB SET:C1220($request; "reference"; "CXR-merchant-1234")  // Optional - 3 chars - must match currency of merchant account AUD/NZD
	OB SET:C1220($request; "particular"; "ewire order")
	
	OB SET:C1220($request; "return_url"; "http://test.lotusfx.com:8082/pmark-success")
	OB SET:C1220($request; "notification_url"; "http://test.lotusfx.com:8082/4DHOOK/PMARK/NUDGE")  //listener on server
	
	//OB SET($request;"display_customer_email";"1")
	//OB SET($request;"store_card";"0")
	//OB SET($request;"store_payment_token";"0")
	//OB SET($request;"token_reference";"[webewires]webewireid")
	//OB SET($request;"type";"purchase")
	//OB SET($request;"merchant_token";"0")
	OB SET:C1220($request; "transaction_source"; "INTERNET")
	//OB SET($request;"button_label";"Pay Now")
End if 






If ($return.success)
	ARRAY TEXT:C222($atProperties; 0)
	OB GET PROPERTY NAMES:C1232($request; $atProperties)
	
	$encodedRequest:=""
	
	For ($i; 1; Size of array:C274($atProperties))
		$encodedRequest:=$encodedRequest+$atProperties{$i}+"="+OB Get:C1224($request; $atProperties{$i}; Is text:K8:3)+"&"
	End for 
	$encodedRequest:=Substring:C12($encodedRequest; 1; Length:C16($encodedRequest)-1)  //strip last &
	
	
	ARRAY TEXT:C222($atHeaderNames; 0)
	ARRAY TEXT:C222($atHeaderValues; 0)
	APPEND TO ARRAY:C911($atHeaderNames; "Content-Type")
	APPEND TO ARRAY:C911($atHeaderValues; "application/x-www-form-urlencoded")
	
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; 120)
	
	Case of 
		: (False:C215)  // object doesn't work
			$status:=HTTP Request:C1158(HTTP POST method:K71:2; "https://uat.paymarkclick.co.nz/api/webpayments/paymentservice/rest/WPRequest"; $request; $response; $atHeaderNames; $atHeaderValues)
		: (True:C214)  //testing URL
			$status:=HTTP Request:C1158(HTTP POST method:K71:2; "https://uat.paymarkclick.co.nz/api/webpayments/paymentservice/rest/WPRequest"; $encodedRequest; $response; $atHeaderNames; $atHeaderValues)
		Else 
			$status:=HTTP Request:C1158(HTTP POST method:K71:2; "https://xxxxxxxxxxxx"; $encodedRequest; $response; $atHeaderNames; $atHeaderValues)
	End case 
	
	
	Case of 
		: ($status=-1)  //error with parameters
			//just pass the $return object back
			WAPI_Log(Current method name:C684; $return.statusText)
			
		: ($status=401)  // unauthorized
			$return.success:=False:C215
			$return.status:=$status
			$return.statusText:="HTTP response status code: "+String:C10($status)+"  UNAUTHORIZED REQUEST"
			
		: ($status=200)  //all REQUEST HAS RETURNED A RESPONSE FROM THE API
			
			//<string xmlns="http://schemas.microsoft.com/2003/10/Serialization/">https://uat.paymarkclick.co.nz:443/webpayments/default.aspx?q=4be29bb977694a06b3b56b4d4c8be75e</string>
			$root:=DOM Parse XML variable:C720($response)
			$ref:=DOM Find XML element:C864($root; "string")
			
			If (OK=1)
				$return.success:=True:C214
				$return.status:=1
				$return.statusText:=$response
				DOM GET XML ELEMENT VALUE:C731($ref; $value)
				$return.url:=$value
				$iPos:=Position:C15("?q="; $return.url)
				If ($iPos>0)
					$return.reference:=Substring:C12($return.url; $iPos+3; Length:C16($return.url))
				End if 
				
				DOM CLOSE XML:C722($root)
				
			Else 
				$return.success:=False:C215
				$return.status:=$status
				$return.statusText:=$response
			End if 
			
			
		Else 
			//ERROR WITH REQUEST
			$return.success:=False:C215
			$return.status:=$status
			$return.statusText:="HTTP response status code: "+String:C10($status)
			
			WAPI_Log(Current method name:C684; $return.statusText)
	End case 
	
End if 

ON ERR CALL:C155($currOnErr)

$0:=$return