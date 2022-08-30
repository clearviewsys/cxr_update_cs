//%attributes = {}
//https://www.polipayments.com/POLiLink

//-------KEYVALUES THAT NEED TO BE CONFIGURED
//getKeyValue ("web.configuration.payments.poli.testmode";"true")
//getKeyValue ("web.configuration.payments.poli.authcode";"T64010031:sK3$XGANDW!ms")
//.     authcode is the merchantid AND authcode set in the Poli Console - separated by a colon
//getKeyValue ("web.configuration.payments.poli.currencycode";"NZD")


// ----- ALL METHODS RETURN AN OBJECTS SIMILAR TO THE WAY 4D DOES WITH ORDA
// return.success -- true/false
// return.status -- numeric value
// return.statusText -- description of the status
// some methods will include additional elements

C_OBJECT:C1216($return)
C_OBJECT:C1216($history; $list; $objectOfParameters)
C_TEXT:C284($theLink; $theStatus)

// 1 -- get a poli link for a payment amount
$return:=POLI_getPaymentLink($objectOfParameters)
If ($return.success)
	$theLink:=$return.statusText  //<-- will contain the link
End if 

//2 -- check the status of a payment linke received in step 1
$return:=POLI_getPaymentStatus($theLink)
If ($return.success)
	$theStatus:=$return.statusText  //<-- Unused/Activated/PartPaid/Future/Completed
End if 

//3 --OPTIONAL - if you want to check the complete history of a given payment link
$return:=POLI_getPaymentDetails($theLink)
If ($return.success)
	$history:=$return.history  //<-- object with TransactionRefNo/BankReceiptNo/BankReceiptDateTime/Status/
	//AmountPaid/CompletionTime/MerchantReference/CustomerReference
End if 

//4 -- OPTIONAL -- if you want a comlete list of ALL payment Links
$return:=POLI_getPaymentList
If ($return.success)
	$list:=$return.list  //< -- object will all polilinks for the merchant
End if 