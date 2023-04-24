//%attributes = {}
// updateAccountBalanceRow (accountID;date)
// UNFINISHED


C_TEXT:C284($accountID; $accountBalanceID; $1)
C_DATE:C307($date; $2)
$accountID:=$1
$date:=$2

$accountBalanceID:=makeAccountBalanceID($accountID; $date)

QUERY:C277([AccountBalances:87]; [AccountBalances:87]AccountBalanceID:1=$accountBalanceID)

// get yesterday's balance and add to today


