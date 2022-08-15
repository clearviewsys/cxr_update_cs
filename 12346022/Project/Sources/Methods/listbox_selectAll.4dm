//%attributes = {}
// selectAll (->listBox)
// highlight all the rows

C_POINTER:C301($listboxPtr; $1)
$listBoxPtr:=$1

C_LONGINT:C283($n; $i)
$n:=LISTBOX Get number of rows:C915($listBoxPtr->)
For ($i; 1; $n)
	$listBoxPtr->{$i}:=True:C214
End for 
