//%attributes = {}
// creates WebEWire record based on finished MoneyGram transaction

C_OBJECT:C1216($1; $mgTransaction; $webEwire; $status)
C_TEXT:C284($0; $webEwireID)

$mgTransaction:=$1

// we use Sequence number command to generate ID and that is not working with ORDA, 
// so create record in advance using "classic" commands

$webEwireID:=mgCreateWebeWireRecord

// create record in logs table in case something goes wrong - MG transaction is already done. no undos here
// so store data about transaction in [WebEWireLogs]Notes as JSON

CREATE RECORD:C68([WebEWireLogs:151])
[WebEWireLogs:151]WebEwireID:7:=Replace string:C233($webEwireID; "WEB"; "MGX")
[WebEWireLogs:151]Notes:6:=JSON Stringify:C1217($mgTransaction; *)
SAVE RECORD:C53([WebEWireLogs:151])
UNLOAD RECORD:C212([WebEWireLogs:151])


$webEwire:=ds:C1482.WebEWires.query("WebEwireID = :1"; $webEwireID).first()

If ($webEwire#Null:C1517)
	
	$webEwire.paymentInfo:=New object:C1471
	$webEwire.paymentInfo.invoiceID:=""  // easier to find later during Invoice creation than to look for null
	$webEwire.paymentInfo.localFee:=0
	$webEwire.paymentInfo.receiptURL:=$mgTransaction.receiptURL
	
	$webEwire.paymentInfo.result:=New object:C1471  // resulting JSON received from MoneyGram after transaction
	$webEwire.paymentInfo.passedToMoneyGram:=New object:C1471  // data we sent to MoneyGram
	$webEwire.paymentInfo.origin:="ProfixWebApp"
	$webEwire.status:=20  // 9/17/22 @ibb assume approved b/c directed by teller
	
	$webEwire.CustomerID:=$mgTransaction.customerID
	$webEwire.paymentInfo.result:=$mgTransaction.result
	$webEwire.paymentInfo.passedToMoneyGram:=$mgTransaction.object
	
	$webEwire.receiptHTML:=$mgTransaction.receiptHTML
	
	If ($mgTransaction.object.transactionType="Send")
		
		$webEwire.WebEwireID:=Replace string:C233($webEwireID; "WEB"; "MGS")
		
		$webEwire.toCountryCode:=mgCountryCode2CXR_CC($mgTransaction.result.destinationCountry)
		$webEwire.fromAmount:=$mgTransaction.result.sendAmount
		$webEwire.fromCCY:=$mgTransaction.result.sendCurrency
		$webEwire.fromFee:=$mgTransaction.result.sendFee
		$webEwire.directRate:=$mgTransaction.result.rate
		$webEwire.toCCY:=$mgTransaction.result.receiveCurrency
		//$webEwire.status:=$mgTransaction.result.transactionStatus // this doens't work b/c text-> longint
		$webEwire.toAmount:=$mgTransaction.result.receiveAmount
		
		// where to get the country branch is located in?
		// $webEwire.fromCountryCode:=mgCountryCode2CXR_CC ($mgTransaction.object.senderCountry)
		
	Else 
		
		$webEwire.WebEwireID:=Replace string:C233($webEwireID; "WEB"; "MGR")
		
		//$webEwire.status:=$mgTransaction.result.transactionStatus // this doens't work b/c text-> longint
		$webEwire.fromAmount:=$mgTransaction.result.sendAmount
		$webEwire.fromCountryCode:=mgCountryCode2CXR_CC($mgTransaction.result.originatedCountry)
		$webEwire.fromCCY:=$mgTransaction.result.sendCurrency
		$webEwire.directRate:=$mgTransaction.result.rate
		$webEwire.toCCY:=$mgTransaction.result.receiveCurrency
		$webEwire.toAmount:=$mgTransaction.result.receiveAmount
		
	End if 
	
	
	$status:=$webEwire.save()
	
	If ($status.success)
		
		$0:=$webEwire.WebEwireID
		
	Else 
		
		// serious error
		
	End if 
	
Else 
	
	// serious error here
	
	
End if 
