//%attributes = {}
// selectActiveAccountsDuring(fromDate;toDate)
C_DATE:C307($1; $2; $fromDate; $toDate)
$fromDate:=$1
$toDate:=$2

selectDateRangeTable(->[Registers:10]; ->[Registers:10]RegisterDate:2; $FromDate; $ToDate)
RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])  // select only the accounts that are related to the registers in that date range
QUERY SELECTION:C341([Accounts:9]; [Accounts:9]isHidden:21=False:C215)
ORDER BY:C49([Accounts:9]; [Accounts:9]MainAccountID:2; >; [Accounts:9]Currency:6; >; [Accounts:9]AccountID:1; >)  // order the accounts by their ledger, currency and name
