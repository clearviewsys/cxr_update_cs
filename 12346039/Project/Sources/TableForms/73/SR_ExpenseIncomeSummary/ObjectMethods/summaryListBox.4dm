//author: Amir
//12th Nov. 2018
//expense transaction summary double click handler for listbox
//showing details of registers for given date range and branch
C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)
C_LONGINT:C283($registerIndex; $numRegisters)
If (Form event code:C388=On Double Clicked:K2:5)
	$ColumnPtr:=Focus object:C278
	$row:=$ColumnPtr->
	If ($row>0)
		FORM GOTO PAGE:C247(2)
	End if 
End if 
