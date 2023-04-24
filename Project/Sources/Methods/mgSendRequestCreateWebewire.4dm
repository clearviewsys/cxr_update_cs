//%attributes = {}
// creates webewire/MoneyGram transaction record based on successful SendRequest SOAP API call
C_OBJECT:C1216($1; $parameters)  // what we passed to a call to SendRequest SOAP API method
C_OBJECT:C1216($2; $result)  // result received from MoneyGram SOAP API call
C_TEXT:C284($3; $customerID)
C_TEXT:C284($0; $webEwireID)
C_OBJECT:C1216($webEwire; $status)

$parameters:=$1
$result:=$2
$customerID:=""

If (Count parameters:C259>2)
	$customerID:=$3
End if 

// we use Sequence number command to generate ID and that is not working with ORDA, 
// so create record in advance using "classic" commands

$webEwireID:=mgCreateWebeWireRecord

$webEwire:=ds:C1482.WebEWires.query("WebEwireID = :1"; $webEwireID).first()

If ($webEwire#Null:C1517)
	If (True:C214)
		$webEwireID:=mgSendRequestCreateWebewire2($webEwire; $parameters; $result; $customerID)
	Else 
		//$webEwire.WebEwireID:=Replace string($webEwireID;"WEB";"MGS")
		
		//$webEwire.CustomerID:=$customerID
		
		//$webEwire.paymentInfo:=New object
		//$webEwire.paymentInfo.invoiceID:=""  // easier to find later during Invoice creation than to look for null
		//$webEwire.paymentInfo.origin:="SOAP"
		
		//  // keep original values used for SOAP call and result
		//$webEwire.paymentInfo.soap:=New object
		//$webEwire.paymentInfo.soap.result:=$result
		//$webEwire.paymentInfo.soap.passed:=$parameters
		//  // --------------
		
		//$webEwire.paymentInfo.result:=New object  // resulting JSON received from MoneyGram after transaction
		//$webEwire.paymentInfo.passedToMoneyGram:=New object  // data we sent to MoneyGram
		
		//  // remap SOAP API properties back to Profix named properties
		
		//$webEwire.paymentInfo.passedToMoneyGram:=mgSendRequest2Profix ($parameters)
		//$webEwire.paymentInfo.result:=mgSendRequest2ProfixResult ($result)
		
		//$webEwire.toCountryCode:=mgCountryCode2CXR_CC ($webEwire.paymentInfo.result.destinationCountry)
		//$webEwire.fromAmount:=$webEwire.paymentInfo.result.sendAmount
		//$webEwire.fromCCY:=$webEwire.paymentInfo.result.sendCurrency
		//$webEwire.fromFee:=$webEwire.paymentInfo.result.sendFee
		//$webEwire.directRate:=$webEwire.paymentInfo.result.rate
		//$webEwire.toCCY:=$webEwire.paymentInfo.result.receiveCurrency
		//$webEwire.status:=$webEwire.paymentInfo.result.transactionStatus
		//$webEwire.toAmount:=$webEwire.paymentInfo.result.receiveAmount
	End if 
	
	$status:=$webEwire.save()
	
	If ($status.success)
		
		$0:=$webEwire.WebEwireID
		
	End if 
	
End if 
