//%attributes = {}


//--- result object ---
//TransactionRefNo |  | The POLi ID associated with the transaction |  | String |  | String |  | A unique 12 digit reference to a POLi transaction
//TransactionStatusCode |  | A code that indicates the terminal status of the transaction |  | String |  | String |  | See Transaction Status
//TransactionID |  | The unique transaction ID which is used internally |  | String |  | String |  | A unique 32 hexadecimal digit reference UUID/GUID to a POLi transaction
//EstablishedDateTime |  | The date and time of the POLi server when the InitiateTransaction request was re |  | Datetime |  | String |  | 
//StartDateTime |  | The date and time the transaction was started |  | Datetime |  | String |  | 
//EndDateTime |  | The date and time the transaction ended |  | Datetime |  | String |  | 

//PaymentAmount |  | The Amount of the transaction |  | Decimal.Valueupto 2 decimal places. |  | Number |  | Attempted payment amount
//AmountPaid |  | The actual amount paid for the transaction |  | Decimal.Valueupto 2 decimal places. |  | Number |  | Actual paid amount
//BankReceipt |  | The Internet banking receipt number provided from the banks receipt page |  | String |  | String |  | 
//BankReceiptDateTime |  | The date and time of the bank receipt |  | String |  | String |  | 

//ErrorCode |  | An error code associated with the transaction, if any |  | String |  | String |  | See Error Codes
//ErrorMessage |  | A description of the error associated with the transaction, if any |  | String |  | String |  | See Error Codes
//IsExpired |  | The status that indicates if the the POLi link for the transaction has expired |  | Boolean |  | Boolean |  | 
//UserIPAddress |  | The IP address that the consumer initiated the transaction |  | String |  | String |  | 
//POLiVersionCode |  | The vector version which was used to complete the transaction |  | String |  | String |  | 


//CurrencyCode |  | The currency of the transaction Note:This must match the currency of your mercha
//.      String |  | String |  | Possible values are aligned with ISO Standard ISO 4217
//CountryName |  | The plain text name of the country the transaction |  | String |  | String |  | 
//CountryCode |  | The code of the country where the transaction takes place |  | String |  | String |  | Possible values are aligned with ISO Standard ISO 3166-1
//MerchantEstablishedDateTime |  | The date and time in the entity's timezone that the transaction was established |  | Datetime |  | String |  | 
//FinancialInstitutionCode |  | The code of the financial institution the payment was made from |  | String |  | String |  | 
//FinancialInstitutionCountryCode |  | The code of the financial institution and country the payment was made from |  | String |  | String |  | 
//FinancialInstitutionName |  | The name of the financial institution the payment was made from |  | String |  | String |  | 
//MerchantReference |  | The merchant reference passed in the InitiateTransaction request |  | String |  | String |  | 
//MerchantData |  | The merchant data that was passed in the InitiateTransaction request for round t |  | String |  | String |  | 
//MerchantAccountName |  | The merchant’s bank account name where the funds were to be paid |  | String |  | String |  | 
//MerchantAccountSortCode |  | The merchant’s account sort code where the funds were to be paid.
//.     Australia: This is the BSB number.
//.     New Zealand: This is the Bank and Branch codes respectively. |  | String |  | String |  | 
//MerchantAccountSuffix |  | The merchant’s account suffix where the funds were to be paid.Note: This is only applicable to New Zealand merchants |  | String |  | String |  | 0
//MerchantAccountNumber |  | The merchant’s account number where the funds were to be paid |  | String |  | String |  | 
//PayerFirstName |  | The first name of the user who paid(if available) |  | String |  | String |  | 
//PayerFamilyName |  | The last name of the user who paid(if available) |  | String |  | String |  | 
//PayerAccountSortCode |  | The payer’s account sort code where the funds were to be paid.
//.    Australia: This is the BSB number.
//.    New Zealand: This is the Bank and Branch codes respectively. |  | String |  | String |  | 
//PayerAccountNumber |  | The account number of the user who paid(if available) |  | String |  | String |  | 
//PayerAccountSuffix |  | The suffix of the user who paid(if available)
//.     Note: This is only applicable to New Zealand merchants |  | String |  | String |  | 
//CurrencyName |  | The plain text name of the transaction currency. |  | String |  | String |  | Possible values are aligned with ISO Standard ISO 4217
//MerchantEntityID |  | The unique Merchant Entity ID related to the transaction which is used internall |  | String |  | String |  | A unique 32 hexadecimal digit reference UUID/GUID to a POLi Merchant
//MerchantName || The merchant name passed in the InitiateTransaction request || String || String


C_TEXT:C284($1; $token)

C_OBJECT:C1216($0; $response)

C_BOOLEAN:C305($isTesting)
C_TEXT:C284($currOnErr)
C_LONGINT:C283($status)
C_OBJECT:C1216($return)


If (Count parameters:C259>=1)
	$token:=$1
Else 
	$token:="lkhnsmiGZqhK7aSedQV09HYXQXN1by4F"
End if 


$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")

$isTesting:=Choose:C955(getKeyValue("web.configuration.payments.poli.testmode"; "true")="true"; True:C214; False:C215)


$response:=New object:C1471
$return:=New object:C1471

ARRAY TEXT:C222($atHeaderNames; 0)
ARRAY TEXT:C222($atHeaderValues; 0)
POLI_setHeaderArrays(->$atHeaderNames; ->$atHeaderValues)

If ($isTesting)  //testing URL
	$status:=HTTP Get:C1157("https://poliapi.uat1.paywithpoli.com/api/v2/Transaction/GetTransaction?token="+$token; $response; $atHeaderNames; $atHeaderValues)
Else 
	$status:=HTTP Get:C1157("https://poliapi.apac.paywithpoli.com/api/v2/Transaction/GetTransaction?token="+$token; $response; $atHeaderNames; $atHeaderValues)
End if 

If ($status=200)
	
	$return.success:=True:C214
	$return.status:=$response.TransactionStatusCode
	$return.statusText:=$response.TransactionStatus
	$return.response:=$response
	
	If ($response.ErrorCode=Null:C1517)  //we have a link
	Else   //error from the API
		If ($response.TransactionStatusCode="")
			$return.status:=$response.ErrorCode
			$return.statusText:=$response.ErrorMessage
		End if 
	End if 
	
Else 
	$return.success:=False:C215
	$return.status:="failed"
	$return.statusText:="HTTP response status code: "+String:C10($status)
	
End if 

$0:=$return

ON ERR CALL:C155($currOnErr)