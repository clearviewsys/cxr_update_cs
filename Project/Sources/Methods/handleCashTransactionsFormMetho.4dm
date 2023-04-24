//%attributes = {}
// handleCashTransactionsFormMethod (isCashIn:bool)
C_REAL:C285(vBalanceBefore; vBalanceAfter)
C_REAL:C285(vAmountLocal_BF; vTotalFees; vInverseRate)
C_REAL:C285(vUnrealizedGain)
C_POINTER:C301($subAccountPtr)

C_BOOLEAN:C305($isCashIn; $1)
$isCashIn:=$1

C_REAL:C285($oldRemaining; vRemaining; vTotal; vDenomination)
C_LONGINT:C283(vQty)


// Modified by: Tiran Behrouz (4/18/13)
// added branchID as a param  ; version 3.900
// IBB 2/22/16 added modBranchID as param
setApplicationUserForTable(->[CashTransactions:36]; ->[CashTransactions:36]UserID:6; ->[CashTransactions:36]UserID:6; ->[CashTransactions:36]BranchID:20; ->[CashTransactions:36]modBranchID:25)


// Modified by: Milan (12/3/2020)
If ([CashTransactions:36]isPaid:2)
	// _O_OBJECT SET COLOR(*;"Rectangle1";calcColour(Yellow;Yellow))
	OBJECT SET RGB COLORS:C628(*; "Rectangle1"; convPalleteColourToRGB(Yellow:K11:2); convPalleteColourToRGB(Yellow:K11:2))
Else 
	// _O_OBJECT SET COLOR(*;"Rectangle1";calcColour(Light blue;Light blue))
	OBJECT SET RGB COLORS:C628(*; "Rectangle1"; convPalleteColourToRGB(Light blue:K11:8); convPalleteColourToRGB(Light blue:K11:8))
End if 


If (onNewRecordEvent)
	setCashTransFieldsToInvoiceVars(Not:C34($isCashIn); makeCashTransactionsID)
	
	//GOTO AREA([CashTransactions]Amount)
	selectCashAccountsForUser(vCurrency)
	
	FIRST RECORD:C50([Accounts:9])
	[CashTransactions:36]CashAccountID:9:=[Accounts:9]AccountID:1
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)  // both for modification and new record
		vQty:=0
		vDenomination:=0
		vBalanceBefore:=0
		vBalanceAfter:=0
		vTotalAmount:=0
		vRemaining:=[CashTransactions:36]Amount:3-vTotalAmount
		
		READ WRITE:C146([CashInOuts:32])  // unlocks the cash in out for modification
		GOTO OBJECT:C206(vQty)
		$subAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "subAccountID")
		If ($subAccountPtr#Null:C1517)  // some form don't have subAccountID dropdown
			handleDropDown_SubAccount($subAccountPtr; ->[CashTransactions:36]SubAccountID:23; [CashTransactions:36]CashAccountID:9; True:C214)
		End if 
		
		//POST OUTSIDE CALL(Current process)  // update the display of lines
		
		relateManyCashInOuts
		setRadioButtonStatesInInvoice(5)
		SET TIMER:C645(-1)
		
	: (Form event code:C388=On Outside Call:K2:11)
		SET TIMER:C645(-1)
		
	: (Form event code:C388=On Timer:K2:25)
		vBalanceBefore:=getAccountBalance([CashTransactions:36]CashAccountID:9)  // the account balance should only be enquired on load
		setBalanceAfter(vBalanceBefore; ->vBalanceAfter; [CashTransactions:36]Amount:3; Not:C34($isCashIn))
		SET TIMER:C645(0)
		
	: (Form event code:C388=On Deactivate:K2:10)
		//BRING TO FRONT(Current process)
		
	: (Form event code:C388=On Close Box:K2:21)
		handleCloseBox
		
	Else 
		
		//_______________________________HANDLING THE LITTLE IMBEDDED CALCULATOR_________________________
		C_BOOLEAN:C305($isPaid; $isReceived)
		C_POINTER:C301($amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
		C_REAL:C285(vAmountLocal_BF; vPercentFeeLocal; vTotalFees; vInverseRate)
		C_TEXT:C284($currency; vCurrency)
		
		$isReceived:=$isCashIn
		$isPaid:=Not:C34($isReceived)
		$currency:=[CashTransactions:36]Currency:4
		
		$amountPtr:=->[CashTransactions:36]Amount:3
		$ratePtr:=->[CashTransactions:36]ourRate:15
		$percentPtr:=->[CashTransactions:36]percentFee:17
		$feeLocalPtr:=->[CashTransactions:36]feeLocal:18
		$amountLocalPtr:=->[CashTransactions:36]amountLocal:19
		$amountLocalBFPtr:=->vAmountLocal_BF
		$percentFeeLocalPtr:=->vPercentFeeLocal
		$totalFeesPtr:=->vTotalFees
		$inverseRatePtr:=->vInverseRate
		//If (Form event=On Load)
		//setRadioButtonStatesInInvoice (5)
		//End if 
		
		C_LONGINT:C283($switch; rb1; b2; rb3; rb4; rb5)
		$switch:=getRadioButtonsSelection(rb1; rb2; rb3; rb4; rb5)
		calculateFieldsInInvoiceRows($switch; $isReceived; $currency; $amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
		//_________________________________________________________________________________________
		If ($isCashIn)
			vTotalAmount:=Sum:C1([CashInOuts:32]TotalIn:10)-Sum:C1([CashInOuts:32]TotalOut:11)
			vUnrealizedGain:=Round:C94(vAmount*([CashTransactions:36]spotRate:16-[CashTransactions:36]ourRate:15); 3)
		Else 
			vTotalAmount:=Sum:C1([CashInOuts:32]TotalOut:11)-Sum:C1([CashInOuts:32]TotalIn:10)
			vUnrealizedGain:=Round:C94(vAmount*([CashTransactions:36]ourRate:15-[CashTransactions:36]spotRate:16); 3)
		End if 
		
		vRemaining:=[CashTransactions:36]Amount:3-vTotalAmount
		vTotal:=vQty*vDenomination
		
		//If (Form event=On Load)
		//vBalanceBefore:=getAccountBalance ([CashTransactions]CashAccountID)  // the account balance should only be enquired on load
		//End if 
		setBalanceAfter(vBalanceBefore; ->vBalanceAfter; [CashTransactions:36]Amount:3; Not:C34($isCashIn))
		
		colorizeNegs(->vUnrealizedGain)
		
End case 

//If ((Form event#On Clicked) & (Form event#On Data Change))
//  relateManyCashInOuts 
//End if 
//If (Form event=On Load)
//relateManyCashInOuts 
//End if 




