//%attributes = {}

// filterSelectedRows (->listBox)
// meaning: deletedUnselectedRows

C_POINTER:C301($listboxPtr; $1)
$listBoxPtr:=$1

C_LONGINT:C283($n; $i)
$n:=LISTBOX Get number of rows:C915($listBoxPtr->)
For ($i; 1; $n)
	If ($i<=$n)
		If ($listBoxPtr->{$i}=False:C215)
			LISTBOX DELETE ROWS:C914($listBoxPtr->; $i)
			$i:=$i-1
			$n:=$n-1
		End if 
	End if 
End for 
