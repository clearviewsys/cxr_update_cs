//%attributes = {}
// getFirstSelectedRow (focus object)
// returns the first selected row number in a listbox

C_POINTER:C301($listboxPtr; $1)
C_LONGINT:C283($0)

$listBoxPtr:=$1
$0:=0

C_LONGINT:C283($i; $n)
$n:=LISTBOX Get number of rows:C915($listBoxPtr->)
$i:=0
If ($n>0)
	Repeat 
		$i:=$i+1
	Until (($listBoxPtr->{$i}=True:C214) | ($i>=$n))
	If ($i<=$n)
		$0:=$i
	End if 
End if 
