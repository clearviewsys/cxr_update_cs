//%attributes = {}
// listbox_appendRow (focus object) --> added row number
C_POINTER:C301($1; $listBoxPtr)
$listBoxPtr:=$1

C_LONGINT:C283($n; $0)
$n:=LISTBOX Get number of rows:C915($listBoxPtr->)+1
LISTBOX INSERT ROWS:C913($listBoxPtr->; $n)
$0:=$n