C_POINTER:C301($columnPtr)
C_LONGINT:C283($row)


If (Form event code:C388=On Data Change:K2:15)
	$ColumnPtr:=Focus object:C278
	// $Column contains a pointer to col2
	$Row:=$ColumnPtr->  //$Row equals 5
	arrOpenings{$row}:=arrOffBalances{$row}+arrClosings{$row}
End if 