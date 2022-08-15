//%attributes = {}
//selectAccountsInDateRange(fromDate;toDate)
// select only the accounts that were active during a date range

C_DATE:C307($fromDate; $toDate; $1; $2)
$fromDate:=$1
$toDate:=$2

selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; $fromDate; $toDate)
RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])
RELATE ONE SELECTION:C349([Accounts:9]; [MainAccounts:28])
orderByMainAccounts