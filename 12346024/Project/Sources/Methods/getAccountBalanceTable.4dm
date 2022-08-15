//%attributes = {}
// getaccountbalanceInDateRange (;->table;->In; ->out;->accountField;->datePtr; accountID; fromDate ; toDate ;boolApplyDate; ->openingBalance; ->sumDebit;->sumCredit; ->balance)

C_POINTER:C301($1; $2; $3; $4; $5; $tablePtr; $InPtr; $outPtr; $dateFieldPtr; $accountPtr)
C_TEXT:C284($accountID; $6)
C_DATE:C307($fromDate; $toDate; $7; $8)
C_BOOLEAN:C305($applyDateRange; $9)
C_POINTER:C301($openingBalancePtr; $sumDebitPtr; $sumCreditPtr; $balancePtr; $10; $11; $12; $13)

$tablePtr:=$1
$inPtr:=$2
$outPtr:=$3
$accountPtr:=$4
$dateFieldPtr:=$5

$accountID:=$6
$fromDate:=$7
$toDate:=$8
$applyDateRange:=$9

$openingBalancePtr:=$10
$sumDebitPtr:=$11
$sumCreditPtr:=$12
$balancePtr:=$13

If ($applyDateRange)
	// 1ST : load all the registers for this account 
	QUERY:C277($tablePtr->; $accountPtr->=$accountID)  // load all the registers for this account
	
	// 2ND : constrain the ending period
	QUERY SELECTION:C341($tablePtr->;  & ; $dateFieldPtr-><=$toDate)
	
	// 3RD: calculate the sum from beginning to end (this is the ending balance)
	$balancePtr->:=Sum:C1($inPtr->)-Sum:C1($outPtr->)
	
	// 4TH: constrain the starting period (this is the period sum)
	QUERY SELECTION:C341($tablePtr->; $dateFieldPtr->>=$fromDate)
	$sumDebitPtr->:=Sum:C1($inPtr->)
	$sumCreditPtr->:=Sum:C1($outPtr->)
	
	// 5th: Calculate the difference of total minus the period sum to get the opening balance
	$openingBalancePtr->:=$balancePtr->-($sumDebitPtr->-$sumCreditPtr->)
	
Else 
	$openingBalancePtr->:=0
	QUERY:C277($tablePtr->; $accountPtr->=$accountID)  // load all the registers for this account
	$sumDebitPtr->:=Sum:C1($inPtr->)
	$sumCreditPtr->:=Sum:C1($outPtr->)
	$balancePtr->:=$sumDebitPtr->-$sumCreditPtr->
	
End if 
