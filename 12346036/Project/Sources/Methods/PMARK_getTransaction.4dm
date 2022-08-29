//%attributes = {}


//GET https:  //secure.paymarkclick.co.nz/api/transaction/search/P170310001234567 HTTP/1.1
//     Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=
//     Content-Type: application/json


// RETURN --- 
//NameDescriptionTypeLength
//transactionId - Paymark Click defined unique transaction ID for this transaction.String8
//originalTransactionId - Used in refund, capture and cancellation transactions.Contains the transaction ID for the related(authorisation or payment)transaction.String8
//type - Transaction type(PURCHASE, AUTHORISATION, STATUS_CHECK, REFUND, CAPTURE, CANCELLATION, OE_PAYMENT).String50
//accountId - The Paymark Click Account ID used for processing the transaction.Integer8
//status - Status of the transaction.0=UNKNOWN, 1=SUCCESSFUL, 2=DECLINED, 3=BLOCKED, 4=FAILED, 5=INPROGRESS, 6=CANCELLED.String50
//transactionDate - Date and time when the transaction was processed.DatetimeN/A
//batchNumber - Content of this data can vary based on type of transaction.Currently when this contains a value, it is a string representing the “estimat.String100
//receiptNumber - Paymark Click defined unique receipt ID.Integer8
//authCode - Authorisation code returned by the Bank for this transaction.String100
//amount - Amount of transaction in NZD, in the format 1.23.Decimal20
//surcharge - If the Merchant has added a surcharge%to this transaction, this is the surcharge amount for this transaction.Note: Contact Paymark to configure a surcharge for your Merchant account.Decimal20
//reference - Reference used for the transaction, as defined by the Merchant.String50
//particular - Particulars used for the transaction, as defined by the Merchant.String50
//cardType - The card type used for this transaction(MASTERCARD, VISA, AMERICAN_EXPRESS, DINERS_CLUB, QCARD).String50
//cardNumber - Masked card number showing first 6 and last 4 digits of the card.String100
//cardExpiry - Expiry date of the card, in the format MMYY.String100
//cardHolder - The Cardholder name entered into the Paymark Click hosted web payment .String100
//cardStored - Whether or not the card was stored, false=not stored, true=stored.Will always be false for Online EFTPOS payments.Boolean10
//cardToken - Payment token ID if a payment(or card)token was used for this transaction and the payment method associated with this .Note: The Merchant can use the Merchant Portal to see payment token details when(associated with the token)is Online EFTPOS.String100
//errorCode - The error code indicating the type of error that occurred.See Response Codes and Messages for a full listing of error codes.String4
//errorMessage - The error message explaining what the error means.See Response Codes and Messages for a full listing of error codes.String510
//acquirer - ResponseCodeResponse code from the acquirer to indicate the status and e.String510
//tokenReference - Merchant defined reference associated with the payment(or card)token used in this transaction, if the payment method associated with this token.Note: The Merchant can use the Merchant Portal to see payment token details when(associated with the token)is Online EFTPOS.String50
//merchant - TokenThe marketing token registered with Paymark for the card used for t.Only available if the merchantToken variable was set to 1.String100
//payerId - Consumer’s personal identifier for Online EFTPOS payments.String100
//payerIdType - Type of payerId that was used for Online EFTPOS payments.String100
//bank - Consumer bank to which the Online EFTPOS payment request was sent.String100
//acsTransactionId - Transaction ID for 3DS 2.Can be used as threeDSRequestorInformation.priorAuthenticationInfo.referencein future 3DS 2 transactions for this cardholder.String50


C_TEXT:C284($1; $token)

C_OBJECT:C1216($0; $return)

C_BLOB:C604($xBlob)
C_OBJECT:C1216($response)
C_BOOLEAN:C305($isTesting)
C_TEXT:C284($currOnErr; $authCode)
C_LONGINT:C283($status)

If (Count parameters:C259>=1)
	$token:=$1
Else 
	$token:="b9d8f88a739e4b958f1cd387524d7590"
End if 

$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")

$return:=New object:C1471

$isTesting:=Choose:C955(getKeyValue("web.configuration.payments.paymark.testmode"; "true")="true"; True:C214; False:C215)

$authCode:=getKeyValue("web.configuration.payments.paymark.username"; "109955")+":"\
+getKeyValue("web.configuration.payments.paymark.password"; "aeX0PNoFKU02wua6")

//$authCode:=getKeyValue ("web.configuration.payments.paymark.accountid";"13971")+":"\
+getKeyValue ("web.configuration.payments.paymark.password";"b2N6iccBlwVNVzQF")

TEXT TO BLOB:C554($authCode; $xBlob; UTF8 text without length:K22:17)
BASE64 ENCODE:C895($xBlob; $authCode)

//$authCode:="MTA5OTU1OmFlWDBQTm9GS1UwMnd1YTY="

ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)

APPEND TO ARRAY:C911($headerNames; "Content-Type")
APPEND TO ARRAY:C911($headerValues; "application/json")
APPEND TO ARRAY:C911($headerNames; "Authorization")
APPEND TO ARRAY:C911($headerValues; "Basic "+$authCode)

If ($isTesting)  //testing URL
	$status:=HTTP Get:C1157("https://uat.paymarkclick.co.nz/api/transaction/search/"+$token; $response; $headerNames; $headerValues)
Else 
	$status:=HTTP Get:C1157("https://secure.paymarkclick.co.nz/api/transaction/search/"+$token; $response; $headerNames; $headerValues)
End if 

Case of 
	: ($status=200)
		
		$return.success:=True:C214
		$return.status:=$response.status
		If ($response.errorMessage=Null:C1517)
			$return.statusText:=$response.status
		Else 
			$return.statusText:=$response.errorMessage
		End if 
		$return.response:=$response
		
		If ($response.ErrorCode=Null:C1517)  //we have a link
		Else   //error from the API
			If ($response.status="")
				$return.status:=$response.errorCode
				$return.statusText:=$response.errorMessage
			End if 
		End if 
		
	: ($status=401)  // unauthorized
		$return.success:=False:C215
		$return.status:=$status
		$return.statusText:="HTTP response status code: "+String:C10($status)+"  UNAUTHORIZED REQUEST"
		
	: ($status=404)  // not found
		$return.success:=False:C215
		$return.status:=$status
		$return.statusText:="HTTP response status code: "+String:C10($status)+"  TRANSACTION NOT FOUND"
		
	Else 
		$return.success:=False:C215
		$return.status:="failed"
		$return.statusText:="HTTP response status code: "+String:C10($status)
		
End case 


$0:=$return

ON ERR CALL:C155($currOnErr)