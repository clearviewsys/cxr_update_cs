C_REAL:C285($denom)
C_LONGINT:C283($position)

$denom:=Num:C11(Request:C163("Add new denomination:"))
$position:=Find in array:C230(arrDenoms; $denom)
If ($position=-1)  // not found the append a row
	listbox_appendRow(->lbTellerProof)
	arrDenoms{Size of array:C274(arrDenoms)}:=$denom
Else 
	myAlert("This denomination already exist in the table")
End if 