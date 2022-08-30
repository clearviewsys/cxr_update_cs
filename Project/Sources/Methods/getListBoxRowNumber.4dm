//%attributes = {}
// getListBoxRowNumber (focusObject) -> row number
// pass the focus object (list box) and it returns the selected row number

C_POINTER:C301($listBoxPtr; $columnPtr; $1)
C_LONGINT:C283($row; $0)
If (Count parameters:C259=0)
	$listBoxPtr:=Focus object:C278
Else 
	$listBoxPtr:=$1
End if 

If (Not:C34(Is nil pointer:C315($listBoxPtr)))
	$ColumnPtr:=$listBoxPtr
	// $Column contains a pointer to the array that has been clicked on
	$row:=$columnPtr->
End if 

If ($row>=0)
	$0:=$row
	
Else   // if negative it means it crossed the line
	
	$0:=(65536+$row)  // when negative
	
End if 

