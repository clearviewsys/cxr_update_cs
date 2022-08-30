//%attributes = {}
// handleChequesFormMethod (isReceived:bool)

C_BOOLEAN:C305($isReceived; $1)
C_REAL:C285(vBalanceBefore; vBalanceAfter)
C_TEXT:C284(INV_vNextAccountID)
C_TEXT:C284(<>CompanyName)
//C_TEXT(vChequeStatus)
$isReceived:=$1

If (onNewRecordEvent)
	
	
	setChequeFieldsToInvoiceVars(Not:C34($isReceived); makechequesID)
	If (INV_vNextAccountID="")
		[Cheques:1]AccountID:7:=makeChequeAccountID(vCurrency; Not:C34($isReceived))
	Else 
		[Cheques:1]AccountID:7:=INV_vNextAccountID
		INV_vNextAccountID:=""
	End if 
	If ($isReceived)
		[Cheques:1]PayTo:15:=<>CompanyName
	Else 
		[Cheques:1]PayTo:15:=[Customers:3]FullName:40
	End if 
	GOTO OBJECT:C206([Cheques:1]ChequeNumber:4)
End if 

If (Form event code:C388=On Load:K2:1)  // both for modification and new record
	vBalanceBefore:=0
	vBalanceAfter:=0
End if 
//vChequeStatus:=getChequeStatusString ([Cheques]chequeStatus)

C_LONGINT:C283($switch)
C_BOOLEAN:C305($isPaid; $isReceived)
C_POINTER:C301($amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)
C_REAL:C285(vAmountLocal_BF; vPercentFeeLocal; vTotalFees; vInverseRate)
C_TEXT:C284($currency; vCurrency)

$switch:=5
$isReceived:=$isReceived
$isPaid:=Not:C34($isReceived)
$currency:=[Cheques:1]Currency:9

$amountPtr:=->[Cheques:1]Amount:8
$ratePtr:=->[Cheques:1]ourRate:19
$percentPtr:=->[Cheques:1]PercentFee:20
$feeLocalPtr:=->[Cheques:1]feeLocal:21
$amountLocalPtr:=->[Cheques:1]amountLocal:23
$amountLocalBFPtr:=->vAmountLocal_BF
$percentFeeLocalPtr:=->vPercentFeeLocal
$totalFeesPtr:=->vTotalFees
$inverseRatePtr:=->vInverseRate
calculateFieldsInInvoiceRows($switch; $isReceived; $currency; $amountPtr; $ratePtr; $percentPtr; $feeLocalPtr; $amountLocalPtr; $amountLocalBFPtr; $percentFeeLocalPtr; $totalFeesPtr; $inverseRatePtr)

If (Form event code:C388=On Load:K2:1)
	vBalanceBefore:=getAccountBalance([Cheques:1]AccountID:7)  // the account balance should only be enquired on load
End if 

setBalanceAfter(vBalanceBefore; ->vBalanceAfter; [Cheques:1]Amount:8; Not:C34($isReceived))
hideObjectsOnTrue(Not:C34([Cheques:1]isPaid:11); "bPickAccountHolder")
//showObjectOnTrue ($isReceived;"chq_Payto@")
showObjectOnTrue($isReceived; "chq_issueBank@")

handleCloseBox