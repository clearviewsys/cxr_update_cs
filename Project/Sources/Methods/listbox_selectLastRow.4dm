//%attributes = {}
// selectLastRow (->listBox)
// this method will scroll to the last line to make it visible for user

C_POINTER:C301($listboxPtr; $1)
$listBoxPtr:=$1

C_LONGINT:C283($n)
$n:=LISTBOX Get number of rows:C915($listBoxPtr->)
If ($n>0)
	LISTBOX SELECT ROW:C912($listBoxPtr->; $n; lk replace selection:K53:1)
End if 

OBJECT SET SCROLL POSITION:C906($listBoxPtr->; $n)