//%attributes = {}
// getTableSelectionBalances
// works like getAccountBalanceTable but only on selection of subfields

C_POINTER:C301($tablePtr; $dateFieldPtr; $inFieldPtr; $outFieldPtr; $1; $2; $3; $4)
C_DATE:C307($fromDate; $toDate; $5; $6)
C_BOOLEAN:C305($applyDateRange; $7)
C_POINTER:C301($openingPtr; $sumInPtr; $sumOutPtr; $balancePtr; $8; $9; $10; $11)

$tablePtr:=$1
$dateFieldPtr:=$2
$inFieldPtr:=$3
$outFieldPtr:=$4

$fromDate:=$5
$toDate:=$6
$applyDateRange:=$7

$openingPtr:=$8
$sumInPtr:=$9
$sumOutPtr:=$10
$balancePtr:=$11

C_REAL:C285($sumInAB; $sumInAC; $sumInBC; $sumOutAB; $sumOutAC; $sumOutBC)
C_REAL:C285($balanceAC; $balanceAB; $balanceBC)

// A____B____C
// A is origin
// B is 'fromDate'
// C is 'toDate'

If ($applyDateRange)
	
	// sum from A to C (all the period) _________
	QUERY SELECTION:C341($tablePtr->; $dateFieldPtr-><=$toDate)
	$sumInAC:=Sum:C1($InFieldPtr->)
	$sumOutAC:=Sum:C1($OutFieldPtr->)
	$balanceAC:=$sumInAC-$sumOutAC
	
	// sum from A to B  (opening) ___________
	QUERY SELECTION:C341($tablePtr->; $dateFieldPtr-><=$fromDate)
	$sumInAB:=Sum:C1($InFieldPtr->)
	$sumOutAB:=Sum:C1($OutFieldPtr->)
	$balanceAB:=$sumInAB-$sumOutAB  // opening balance
	
	// sum from B to C   (period sum) ________
	$sumInBC:=$sumInAC-$sumInAB
	$sumOutBC:=$sumOutAC-$sumOutAB
	$balanceBC:=$sumInBC-$sumOutBC
	
	//________________________________________
	$openingPtr->:=$balanceAB
	$sumInPtr->:=$sumInBC
	$sumOutPtr->:=$sumOutBC
	$balancePtr->:=$sumInAC-$sumOutAC
	
Else 
	//ALL RECORDS($tablePtr->)
	$openingPtr->:=0
	$sumInPtr->:=Sum:C1($InFieldPtr->)
	$sumOutPtr->:=Sum:C1($OutFieldPtr->)
	$balancePtr->:=$sumInPtr->-$sumOutPtr->
	
End if 


