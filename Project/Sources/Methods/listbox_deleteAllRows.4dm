//%attributes = {}
// deleteAllRows (focus object)
C_POINTER:C301($listboxPtr; $1)
C_LONGINT:C283($n; $i)

$listboxPtr:=$1
$n:=LISTBOX Get number of rows:C915($listBoxPtr->)
//For ($i;1;$n)
LISTBOX DELETE ROWS:C914($listBoxPtr->; 1; $n)  //  (it must always delete the first row)
//End for 