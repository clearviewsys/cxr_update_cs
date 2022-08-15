//%attributes = {"executedOnServer":true}
// getAccountTotalsForPrint (->[TABLE];->realField) -> SUM

// returns the sum of a field just like the method Sum

// but this method is to be used in printing 

// for some reason the Sum doesn't work in printing detail


C_TEXT:C284($1)
C_REAL:C285($0; $totalCredit; $totalDebit)
C_POINTER:C301($2; $3)
READ ONLY:C145([Registers:10])
QUERY:C277([Registers:10]; [Registers:10]AccountID:6=$1)

// IMPORTANT ; for whatever reason the 4D COMMAND 'Sum' DOESN'T WORK IN PRINT DETAILS

//*********************************************************************************************

If (False:C215)  // without sum (looping through the selection)
	$totalDebit:=[Accounts:9]OpeningDebit:9+sumSelection(->[Registers:10]; ->[Registers:10]Debit:8)
	$totalCredit:=[Accounts:9]OpeningCredit:8+sumSelection(->[Registers:10]; ->[Registers:10]Credit:7)
Else   // with sum
	$totalDebit:=[Accounts:9]OpeningDebit:9+Sum:C1([Registers:10]Debit:8)
	$totalCredit:=[Accounts:9]OpeningCredit:8+Sum:C1([Registers:10]Credit:7)
End if 

$2->:=$totalDebit
$3->:=$totalCredit
$0:=$totalDebit-$totalCredit