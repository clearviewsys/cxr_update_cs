//%attributes = {}
//selectAccountsInDateRange(fromDate;toDate; {applyDateRange})
// select only the accounts that were active during a date range
C_DATE:C307($fromDate; $toDate; $1; $2)
C_BOOLEAN:C305($applyDateRange; $3)
MESSAGES OFF:C175
$fromDate:=$1
$toDate:=$2

If (Count parameters:C259=3)
	$applyDateRange:=$3
Else 
	$applyDateRange:=False:C215
End if 

If ($applyDateRange)
	selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; $fromDate; $toDate)
Else 
	ALL RECORDS:C47([Registers:10])
End if 

RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])
filterHiddenAccounts
orderByAccounts
MESSAGES ON:C181
