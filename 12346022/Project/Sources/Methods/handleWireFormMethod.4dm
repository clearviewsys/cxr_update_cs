//%attributes = {}
//%attributes = {"lang":"en"} comment added and reserved by 4D.
// handleWiresFormMethod (isPay:bool)
C_REAL:C285(vBalanceBefore; vBalanceAfter)
C_TEXT:C284(vBankAccountID)

C_BOOLEAN:C305($isPay; $1)
$isPay:=$1

If (onNewRecordEvent)
	C_DATE:C307(vDate)
	setWireFieldsToInvoiceVars($isPay; makeWiresID)
	C_DATE:C307($valueDate; $estimatedDate)
	// 
	If ($isPay)
		$valueDate:=Add to date:C393(Current date:C33; 0; 0; Num:C11(getKeyValue("Wires.pay.AddToValueDate"; "0")))
		$estimatedDate:=Add to date:C393($valueDate; 0; 0; Num:C11(getKeyValue("Wires.pay.AddToEstimatedDate"; "0")))
	Else 
		$valueDate:=Add to date:C393(Current date:C33; 0; 0; Num:C11(getKeyValue("Wires.Receive.AddToValueDate"; "0")))
		$estimatedDate:=Add to date:C393($valueDate; 0; 0; Num:C11(getKeyValue("Wires.Receive.AddToEstimatedDate"; "0")))
	End if 
	
	[Wires:8]WireTransferDate:17:=$valueDate
	[Wires:8]EstimatedValueDate:18:=$estimatedDate
	[Wires:8]AML_PurposeOfTransaction:49:=[Invoices:5]AMLPurposeOfTransaction:85
	[Wires:8]AML_SourceOfFunds:66:=[Invoices:5]SourceOfFund:68
End if 

If (Form event code:C388=On Load:K2:1)  // both for modification and new record
	vBalanceBefore:=0
	vBalanceAfter:=0
	If (getKeyValue("currencyCloud.activated")="true")
		If ([Wires:8]Currency:15="CNY")
			OBJECT SET VISIBLE:C603(*; "h_ccPurposeCode"; True:C214)
			OBJECT SET VISIBLE:C603(*; "f_CNYPurposeCode"; True:C214)
		End if 
		If ([Wires:8]Currency:15="INR")
			OBJECT SET VISIBLE:C603(*; "h_ccPurposeCode"; True:C214)
			OBJECT SET VISIBLE:C603(*; "f_INRPurposeCode"; True:C214)
			
		End if 
		If ([Wires:8]Currency:15="MYR")
			OBJECT SET VISIBLE:C603(*; "h_ccPurposeCode"; True:C214)
			OBJECT SET VISIBLE:C603(*; "f_MYRPurposeCode"; True:C214)
			
		End if 
	End if 
End if 

//_______________________________HANDLING THE LITTLE IMBEDDED CALCULATOR_________________________
If (ds:C1482.WebEWires.query("eWireID == :1"; [Wires:8]CXR_WireID:1).length=0)
	C_LONGINT:C283($switch)
	C_BOOLEAN:C305($isPaid; $isReceived)
	C_POINTER:C301($amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
	C_REAL:C285(vAmountLocal_BF; vPercentFeeLocal; vTotalFees; vInverseRate)
	C_TEXT:C284($currency; vCurrency)
	
	$switch:=5
	$isReceived:=Not:C34($isPay)
	$isPaid:=Not:C34($isReceived)
	$currency:=[Wires:8]Currency:15
	
	$amountPtr:=->[Wires:8]Amount:14
	$ratePtr:=->[Wires:8]OurRate:21
	$percentPtr:=->[Wires:8]PercentageFee:23
	$feeLocalPtr:=->[Wires:8]FlatFeeLocal:24
	$amountLocalPtr:=->[Wires:8]AmountLocal:25
	$amountLocalBFPtr:=->vAmountLocal_BF
	$percentFeeLocalPtr:=->vPercentFeeLocal
	$totalFeesPtr:=->vTotalFees
	$inverseRatePtr:=->vInverseRate
	calculateFieldsInInvoiceRows($switch; $isReceived; $currency; $amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
End if 
//_________________________________________________________________________________________

handleCloseBox