If (Form event code:C388=On Data Change:K2:15)
	C_POINTER:C301($columnPtr)
	C_LONGINT:C283($row)
	
	$ColumnPtr:=Focus object:C278
	// $Column contains a pointer to col2
	$Row:=$ColumnPtr->  //$Row equals 5
	setOffBalanceArrayRow($row)
End if 