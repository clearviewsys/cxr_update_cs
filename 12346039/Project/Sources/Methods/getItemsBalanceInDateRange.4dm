//%attributes = {}
// getaccountbalanceInDateRange (accountID; fromDate ; toDate ;boolApplyDate; ->openingBalance; ->sumDebit;->sumCredit; ->balance)


C_TEXT:C284($itemID; $1)
C_DATE:C307($fromDate; $toDate; $2; $3)
C_BOOLEAN:C305($applyDateRange; $4)
C_POINTER:C301($openingBalancePtr; $sumDebitPtr; $sumCreditPtr; $balancePtr; $5; $6; $7; $8)
C_POINTER:C301($sumCreditLocalPtr; $sumDebitLocalPtr; $9; $10)
C_REAL:C285($balanceLocal; $sumCreditLocal; $sumDebitLocal)
$itemID:=$1
$fromDate:=$2
$toDate:=$3
$applyDateRange:=$4

$openingBalancePtr:=$5
$sumDebitPtr:=$6
$sumCreditPtr:=$7
$balancePtr:=$8

If (Count parameters:C259=10)
	$sumDebitLocalPtr:=$9
	$sumCreditLocalPtr:=$10
End if 

If ($applyDateRange)
	// 1ST : load all the registers for this account 
	QUERY:C277([ItemInOuts:40]; [ItemInOuts:40]ItemID:2=$itemID)  // load all the registers for this account
	
	// 2ND : constrain the ending period
	QUERY SELECTION:C341([ItemInOuts:40];  & ; [ItemInOuts:40]Date:3<=$toDate)
	
	// 3RD: calculate the sum from beginning to end (this is the ending balance)
	$balancePtr->:=Sum:C1([ItemInOuts:40]Qty:8)-Sum:C1([ItemInOuts:40]QtySold:23)
	$balanceLocal:=Sum:C1([ItemInOuts:40]amountLocal:25)-Sum:C1([ItemInOuts:40]AmountSold:24)
	
	// 4TH: constrain the starting period (this is the period sum)
	QUERY SELECTION:C341([ItemInOuts:40]; [ItemInOuts:40]Date:3>=$fromDate)
	$sumDebitPtr->:=Sum:C1([ItemInOuts:40]Qty:8)-Sum:C1([ItemInOuts:40]QtySold:23)
	$sumCreditPtr->:=Sum:C1([ItemInOuts:40]QtySold:23)
	
	$sumDebitLocal:=Sum:C1([ItemInOuts:40]amountLocal:25)-Sum:C1([ItemInOuts:40]AmountSold:24)
	$sumCreditLocal:=Sum:C1([ItemInOuts:40]AmountSold:24)
	
	// 5th: Calculate the difference of total minus the period sum to get the opening balance
	$openingBalancePtr->:=$balancePtr->-($sumDebitPtr->-$sumCreditPtr->)
	
Else 
	$openingBalancePtr->:=0
	QUERY:C277([ItemInOuts:40]; [ItemInOuts:40]ItemID:2=$itemID)  // load all the registers for this account
	$sumDebitPtr->:=Sum:C1([ItemInOuts:40]Qty:8)-Sum:C1([ItemInOuts:40]QtySold:23)
	$sumCreditPtr->:=Sum:C1([ItemInOuts:40]QtySold:23)
	$balancePtr->:=$sumDebitPtr->-$sumCreditPtr->
	$sumDebitLocal:=Sum:C1([ItemInOuts:40]Amount:22)-Sum:C1([ItemInOuts:40]AmountSold:24)
	$sumCreditLocal:=Sum:C1([ItemInOuts:40]AmountSold:24)
	
End if 

If (Count parameters:C259=10)
	$sumDebitLocalPtr->:=$sumDebitLocal
	$sumCreditLocalPtr->:=$sumCreditLocal
End if 

