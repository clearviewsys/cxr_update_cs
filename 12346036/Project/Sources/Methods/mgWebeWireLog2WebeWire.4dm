//%attributes = {}

// ----------------------------------------------------
// User name (OS): LFX
// Date and time: 21/05/21, 06:07:59
// ----------------------------------------------------
// Method: mgWebeWireLog2WebeWire
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $webEwireLogID; $strToReplace)
C_OBJECT:C1216($webEwire; $status)

$webEwireLogID:=$1

If (Position:C15("WEB"; $webEwireLogID)>0)
	$strToReplace:="WEB"
Else 
	$strToReplace:="MGX"
End if 

C_OBJECT:C1216($eWireLog; $ewire; $mgTransaction)

$eWireLog:=ds:C1482.WebEWireLogs.query("WebEwireID = :1"; $webEwireLogID).first()

If ($eWireLog#Null:C1517)
	
	If ($eWireLog.Notes#"")
		
		$mgTransaction:=JSON Parse:C1218($eWireLog.Notes)
		
		$webEwire:=ds:C1482.WebEWires.query("WebEwireID = :1"; $webEwireLogID).first()
		
		If ($webEwire=Null:C1517)
			$webEwire:=ds:C1482.WebEWires.new()
		End if 
		
		$webEwire.paymentInfo:=New object:C1471
		$webEwire.paymentInfo.invoiceID:=""  // easier to find later during Invoice creation than to look for null
		$webEwire.paymentInfo.localFee:=0
		$webEwire.paymentInfo.result:=New object:C1471  // resulting JSON received from MoneyGram after transaction
		$webEwire.paymentInfo.passedToMoneyGram:=New object:C1471  // data we sent to MoneyGram
		
		$webEwire.CustomerID:=$mgTransaction.customerID
		$webEwire.paymentInfo.result:=$mgTransaction.result
		$webEwire.paymentInfo.passedToMoneyGram:=$mgTransaction.object
		
		If ($mgTransaction.object.transactionType="Send")
			
			$webEwire.WebEwireID:=Replace string:C233($webEwireLogID; $strToReplace; "MGS")
			
			$webEwire.toCountryCode:=mgCountryCode2CXR_CC($mgTransaction.result.destinationCountry)
			$webEwire.fromAmount:=$mgTransaction.result.sendAmount
			$webEwire.fromCCY:=$mgTransaction.result.sendCurrency
			$webEwire.fromFee:=$mgTransaction.result.sendFee
			$webEwire.directRate:=$mgTransaction.result.rate
			$webEwire.toCCY:=$mgTransaction.result.receiveCurrency
			$webEwire.status:=$mgTransaction.result.transactionStatus
			$webEwire.toAmount:=$mgTransaction.result.receiveAmount
			$webEwire.fromCountryCode:=mgCountryCode2CXR_CC($mgTransaction.object.sendCountry)
			
		Else 
			
			$webEwire.WebEwireID:=Replace string:C233($webEwireLogID; $strToReplace; "MGR")
			
			$webEwire.status:=$mgTransaction.result.transactionStatus
			$webEwire.fromAmount:=$mgTransaction.result.sendAmount
			$webEwire.fromCountryCode:=mgCountryCode2CXR_CC($mgTransaction.result.originatedCountry)
			$webEwire.fromCCY:=$mgTransaction.result.sendCurrency
			$webEwire.directRate:=$mgTransaction.result.rate
			$webEwire.toCCY:=$mgTransaction.result.receiveCurrency
			$webEwire.toAmount:=$mgTransaction.result.receiveAmount
			
		End if 
		
		
		$status:=$webEwire.save()
		
		If ($status.success)
			
			
		Else 
			
			// serious error
			
		End if 
		
	End if 
	
End if 
