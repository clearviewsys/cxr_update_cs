//%attributes = {}
// deleteSelectedRows (->listBox)

C_POINTER:C301($listboxPtr; $1)
$listBoxPtr:=$1

C_LONGINT:C283($n; $i; $count; $oneRow)
$n:=LISTBOX Get number of rows:C915($listBoxPtr->)
For ($i; 1; $n)
	If ($i<=$n)
		If ($listBoxPtr->{$i}=True:C214)
			LISTBOX DELETE ROWS:C914($listBoxPtr->; $i)
			$i:=$i-1
			$n:=$n-1
			$count:=$count+1
			$oneRow:=$i
		End if 
	End if 
End for 


If (($count=1) & ($oneRow>0))
	$listBoxPtr->{$oneRow}:=True:C214
End if 