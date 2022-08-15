//%attributes = {}
// getAccountType ( number 1-5 ) -> string
// 
// 1 - Assets
// 2 - Liabilities
// 3 - Equities
// 4 - Revenues
// 5 - Expenses

C_LONGINT:C283($1)
C_TEXT:C284($0)
$0:=""
ARRAY TEXT:C222($arrAccountTypes; 5)
LIST TO ARRAY:C288("AccountTypes"; $arrAccountTypes)

$0:=$arrAccountTypes{$1}
CLEAR VARIABLE:C89($arrAccountTypes)