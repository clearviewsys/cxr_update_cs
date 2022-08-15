//%attributes = {}
//displayGrid_Accounts
// experimental Entity Selection based sub-ledger
// #test #grid #orda
// getBuild

C_LONGINT:C283($win)
C_OBJECT:C1216($obj)

$obj:=New object:C1471
$obj.searchString:=""

$win:=Open form window:C675([Accounts:9]; "ES_ListBox"; Plain form window:K39:10)
DIALOG:C40([Accounts:9]; "ES_ListBox"; $obj)
//[registers]accountID

//getAccountBalance
