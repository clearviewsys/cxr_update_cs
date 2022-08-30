//%attributes = {}
// checkifAccountisOfCurrency (fieldAccountID; currency)


C_TEXT:C284($1; $accountID)
C_TEXT:C284($2; $currency)
$accountID:=$1
$currency:=$2


QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$accountID)
checkAddErrorIf(([Accounts:9]Currency:6#$currency); $accountID+" must be of currency "+$currency)
