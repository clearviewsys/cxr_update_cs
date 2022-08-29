//%attributes = {}
// getaccountbalanceInDateRange (accountID; fromDate ; toDate ;boolApplyDate; ->openingBalance;->transferIn;->transferOut; ->sumDebit;->sumCredit; ->balance)
// This method should run on the Server side. So make sure 'Execute on Server' is on
// This method is at least 3 times faster when executed on the server side

C_TEXT:C284($accountID; $1)
C_DATE:C307($fromDate; $toDate; $2; $3)
C_BOOLEAN:C305($applyDateRange; $4)
C_POINTER:C301($openingBalancePtr; $transferInPtr; $transferOutPtr; $sumDebitPtr; $sumCreditPtr; $balancePtr; $5; $6; $7; $8; $9; $10)
C_POINTER:C301($sumCreditLocalPtr; $sumDebitLocalPtr; $sumFeesPtr; $unrealizedGainPtr; $11; $12; $13; $14)
C_TEXT:C284($branchID; $15)

C_REAL:C285($sumCreditLocal; $sumDebitLocal; $sumFees; $sumUnrealizedGain; $balanceLocal)



$accountID:=$1
$fromDate:=$2
$toDate:=$3
$applyDateRange:=$4

$openingBalancePtr:=$5
$transferInPtr:=$6
$transferOutPtr:=$7

$sumDebitPtr:=$8
$sumCreditPtr:=$9
$balancePtr:=$10

If (Count parameters:C259>=12)
	$sumDebitLocalPtr:=$11
	$sumCreditLocalPtr:=$12
End if 

If (Count parameters:C259>=13)
	$sumFeesPtr:=$13
End if 

If (Count parameters:C259>=14)
	$unrealizedGainPtr:=$14
End if 

If (Count parameters:C259>=15)
	$branchID:=$15
Else 
	$branchID:=""
End if 

If ($applyDateRange)
	// 1ST : load all the registers for this account 
	//QUERY([Registers];[Registers]AccountID=$accountID)  // load all the registers for this account
	queryRegitersByAccountID($accountID; $branchID)
	
	// 2ND : constrain the ending period - period [0 to B]
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate)
	
	// 3RD: calculate the sum from beginning to end (this is the ending balance)
	$balancePtr->:=Sum:C1([Registers:10]Debit:8)-Sum:C1([Registers:10]Credit:7)
	$balanceLocal:=Sum:C1([Registers:10]DebitLocal:23)-Sum:C1([Registers:10]CreditLocal:24)
	
	// 4TH: constrain the starting period (this is the period sum) - [A to B]
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$fromDate)
	$sumDebitPtr->:=Sum:C1([Registers:10]Debit:8)
	$sumCreditPtr->:=Sum:C1([Registers:10]Credit:7)
	$sumDebitLocal:=Sum:C1([Registers:10]DebitLocal:23)
	$sumCreditLocal:=Sum:C1([Registers:10]CreditLocal:24)
	
	// 5th: Calculate the difference of total minus the period sum to get the opening balance - [0 to A)
	$openingBalancePtr->:=$balancePtr->-($sumDebitPtr->-$sumCreditPtr->)
	
Else 
	$openingBalancePtr->:=0
	queryRegitersByAccountID($accountID; $branchID)
	
	$sumDebitPtr->:=Sum:C1([Registers:10]Debit:8)
	$sumCreditPtr->:=Sum:C1([Registers:10]Credit:7)
	$balancePtr->:=$sumDebitPtr->-$sumCreditPtr->
	$sumDebitLocal:=Sum:C1([Registers:10]DebitLocal:23)
	$sumCreditLocal:=Sum:C1([Registers:10]CreditLocal:24)
End if 

$sumFees:=Sum:C1([Registers:10]totalFees:30)  // added in version 3.800 by TB
$sumUnrealizedGain:=Sum:C1([Registers:10]UnrealizedGain:56)

// filter out the transfers only
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=True:C214)
$transferInPtr->:=Sum:C1([Registers:10]Debit:8)
$transferOutPtr->:=Sum:C1([Registers:10]Credit:7)

// recalculate the buy/sell by subtracting the transfer amounts
$sumDebitPtr->:=$sumDebitPtr->-$transferInPtr->
$sumCreditPtr->:=$sumCreditPtr->-$transferOutPtr->


If (Count parameters:C259>=12)  // TB fixed a bug in version 3.423 (Oct 24, 2009); 
	$sumDebitLocalPtr->:=$sumDebitLocal
	$sumCreditLocalPtr->:=$sumCreditLocal
End if 

If (Count parameters:C259>=13)  // added by TB in version 3.800
	$sumFeesPtr->:=$sumFees
End if 

If (Count parameters:C259>=14)
	$unrealizedGainPtr->:=$sumUnrealizedGain
End if 
