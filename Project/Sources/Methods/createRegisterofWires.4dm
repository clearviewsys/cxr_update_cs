//%attributes = {}
// createRegisterOfWires


C_POINTER:C301($tablePtr)
C_TEXT:C284($extRef; $invoiceID; $registerId; $accountID; $subAccountID; $referenceNo)
C_REAL:C285($amount)
C_TEXT:C284($currency)
C_BOOLEAN:C305($isReceived)
C_DATE:C307($issueDate; $dueDate)
C_POINTER:C301($autoCMTPtr)
C_REAL:C285($pctFee; $feeLocal; $ourRate; $spotRate)
C_TEXT:C284($customerID)
C_REAL:C285($amountLocal)

$tablePtr:=->[Wires:8]
$extRef:=[Wires:8]CXR_WireID:1
$invoiceID:=[Wires:8]CXR_InvoiceID:12
$registerId:=[Wires:8]CXR_RegisterID:13

$accountID:=[Wires:8]CXR_AccountID:11
If ([Wires:8]CXR_SubAccountID:61="")
	$subAccountID:=[Wires:8]BeneficiaryCountry:53
Else 
	$SubAccountID:=[Wires:8]CXR_SubAccountID:61
End if 
$referenceNo:=[Wires:8]WireNo:48

$amount:=[Wires:8]Amount:14
$currency:=[Wires:8]Currency:15
$isReceived:=Not:C34([Wires:8]isOutgoingWire:16)
$issueDate:=[Wires:8]WireTransferDate:17
$dueDate:=[Wires:8]EstimatedValueDate:18
$autoCMTPtr:=->[Wires:8]AutoComments:20
$pctFee:=[Wires:8]PercentageFee:23
$feeLocal:=[Wires:8]FlatFeeLocal:24
$ourRate:=[Wires:8]OurRate:21
$spotRate:=[Wires:8]SpotRate:22
$customerID:=[Wires:8]CustomerID:2
$amountLocal:=[Wires:8]AmountLocal:25


[Wires:8]AutoComments:20:=makeCommentsWires

// change in version 3.550 -------------------------------------------------------------------
//[Wires]RegisterID:=createRegisterFromTable ($tablePtr;$extRef;$invoiceID;$registerId;$accountID;$amount;$currency;$isReceived;$issueDate;$dueDate;$autoCMTPtr;$pctFee;$feeLocal;$ourRate;$spotRate;$customerID;$amountLocal)

C_TEXT:C284($branchID; $userID; $currencyAlias)
C_REAL:C285($boardBuyRate; $boardSellRate; $tax1; $tax2)
C_DATE:C307($date)
C_BOOLEAN:C305($isTransfer)

$currencyAlias:=$currency  // must change
$boardBuyRate:=0
$boardSellRate:=0
$userID:=getApplicationUser
$branchID:=getBranchID
$date:=$issueDate
$isTransfer:=False:C215
$tax1:=0
$tax2:=0

[Wires:8]CXR_RegisterID:13:=createRegisterFromTable($branchID; $tablePtr; $extRef; $invoiceID; $registerId; $date; $userID; $accountID; $subAccountID; $referenceNo; $amount; $currency; $isReceived; $autoCMTPtr; $pctFee; $feeLocal; $ourRate; $spotRate; $customerID; $amountLocal; $isTransfer; $tax1; $tax2; $currencyAlias; $boardBuyRate; $boardSellRate)
