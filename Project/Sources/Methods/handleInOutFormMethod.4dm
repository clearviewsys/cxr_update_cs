//%attributes = {}
// handleInOutsFormMethod (isPay:bool)

C_BOOLEAN:C305($isPay; $1)
C_REAL:C285(vBalanceBefore; vBalanceAfter)

$isPay:=$1

C_REAL:C285($oldRemaining; vRemaining)

If (onNewRecordEvent)
	C_DATE:C307(vDate)
	setAccInOutFieldsToInvoiceVars($isPay; makeAccountInOutID)
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)  // both for modification and new record
		vBalanceBefore:=0
		vBalanceAfter:=0
		GOTO OBJECT:C206([AccountInOuts:37]AccountID:6)
		
		If ($isPay)
			stampText("stamp"; "Paid ➖"; "orange"; True:C214)
		Else 
			stampText("stamp"; "Received ➕"; "blue"; True:C214)
		End if 
		
		setRadioButtonStatesInInvoice(5)
		
		SET TIMER:C645(-1)
		
		
	: (Form event code:C388=On Outside Call:K2:11)  // the balance shall be caldulated on these two events
		//  vBalanceBefore:=getAccountBalance ([AccountInOuts]AccountID)  // the account balance should only be enquired on load
		//vBalanceBefore:=0
		//vBalanceAfter:=0
		SET TIMER:C645(-1)
		
		
		
	: (Form event code:C388=On Timer:K2:25)
		vBalanceBefore:=getAccountBalance([AccountInOuts:37]AccountID:6)  // the account balance should only be enquired on load
		setBalanceAfter(vBalanceBefore; ->vBalanceAfter; [AccountInOuts:37]Amount:7; $isPay)
		SET TIMER:C645(0)
		
		
	: (Form event code:C388=On Close Box:K2:21)
		handleCloseBox
		
	Else 
		//_______________________________HANDLING THE LITTLE IMBEDDED CALCULATOR_________________________
		C_BOOLEAN:C305($isPaid; $isReceived)
		C_POINTER:C301($amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
		C_REAL:C285(vAmountLocal_BF; vPercentFeeLocal; vTotalFees; vInverseRate)
		C_TEXT:C284($currency; vCurrency)
		
		$switch:=5
		$isReceived:=Not:C34($isPay)
		$isPaid:=Not:C34($isReceived)
		$currency:=[AccountInOuts:37]Currency:8
		
		$amountPtr:=->[AccountInOuts:37]Amount:7
		$ratePtr:=->[AccountInOuts:37]ourRate:13
		$percentPtr:=->[AccountInOuts:37]percentFee:15
		$feeLocalPtr:=->[AccountInOuts:37]feeLocal:16
		$amountLocalPtr:=->[AccountInOuts:37]amountLocal:17
		$amountLocalBFPtr:=->vAmountLocal_BF
		$percentFeeLocalPtr:=->vPercentFeeLocal
		$totalFeesPtr:=->vTotalFees
		$inverseRatePtr:=->vInverseRate
		
		C_LONGINT:C283($switch; rb1; b2; rb3; rb4; rb5)
		$switch:=getRadioButtonsSelection(rb1; rb2; rb3; rb4; rb5)
		calculateFieldsInInvoiceRows($switch; $isReceived; $currency; $amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
		
		setBalanceAfter(vBalanceBefore; ->vBalanceAfter; [AccountInOuts:37]Amount:7; $isPay)
End case 



//If (Form event=On Load)
//setRadioButtonStatesInInvoice (5)
//End if 

//_________________________________________________________________________________________

