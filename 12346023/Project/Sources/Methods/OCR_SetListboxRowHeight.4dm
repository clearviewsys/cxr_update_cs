//%attributes = {}
// OCR_SetListboxRowHeight (->arrText; ->Listbox)
// Set Listbox Row height based on it max length string

C_POINTER:C301($1; $arrTextPtr; $2; $listboxPtr)
C_LONGINT:C283($i; $n; $max)

$max:=0
$arrTextPtr:=$1
$listboxPtr:=$2


For ($i; 1; Size of array:C274($arrTextPtr->))
	If (Length:C16($arrTextPtr->{$i})>$max)
		$max:=Length:C16($arrTextPtr->{$i})
	End if 
End for 


// Set ROWS HEIGHT depending on the text length
C_LONGINT:C283($n)
$n:=Round:C94($max/40; 0)+1

If ($n>1)
	LISTBOX SET ROWS HEIGHT:C835($listboxPtr->; $n; 1)  // in lines
End if 