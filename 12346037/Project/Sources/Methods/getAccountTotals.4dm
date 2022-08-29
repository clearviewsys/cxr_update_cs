//%attributes = {"executedOnServer":true}
// getAccountTotals(accountID; ->vTotalDebit;->vTotalCredit;->balance;->sumDebitsLocal;->sumCreditsLocal;->balanceLocal); -> balance (debit - credit)

C_TEXT:C284($1)
// getAccountTotals(accountID;->sumD;->sumC;->bal;->sumD_Local;->sumC_Locla;->bal_Local)

C_REAL:C285($totalCredit; $totalDebit; $balance; $totalDebitLocal; $totalCreditLocal; $balanceLocal; $0)
C_POINTER:C301($2; $3; $4; $5; $6; $7)
C_DATE:C307($fromDate; $toDate; $8; $9)
C_BOOLEAN:C305($applyDateRange; $10)

READ ONLY:C145([Registers:10])
$2->:=0
$3->:=0
$4->:=0
$5->:=0
$6->:=0
$7->:=0
$applyDateRange:=False:C215

If (Count parameters:C259=10)
	$fromDate:=$8
	$toDate:=$9
	$applyDateRange:=$10
End if 

If ($1#"")
	QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$1)
	filterRegistersInDateRange($fromDate; $toDate; $applyDateRange)
	
	If (Records in selection:C76([Registers:10])>0)
		getRegisterSums($5; $6; $7; $2; $3; $4)
		$0:=$5->-$6->
	End if 
End if 