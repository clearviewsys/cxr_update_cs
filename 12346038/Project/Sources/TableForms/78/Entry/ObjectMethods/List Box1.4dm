If (Form event code:C388=On Data Change:K2:15)
	C_POINTER:C301($columnPtr)
	C_LONGINT:C283($row)
	
	$ColumnPtr:=Focus object:C278
	$Row:=$ColumnPtr->
	calcTellerProofTotalForRow($row)
End if 
