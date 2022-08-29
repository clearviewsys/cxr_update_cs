
//C_POINTER($columnPtr)
//C_INTEGER($row)
//
//
//$ColumnPtr:=Focus object
//$Row:=$ColumnPtr->  `$Row equals 5
//  ` $Column contains a pointer to col2
//EDIT ITEM(cur_RateTable;$row)
C_LONGINT:C283(cbUseInverseRates)

If (cbUseInverseRates=1)
	listbox_editCurrentRow("invBuyRate"; Focus object:C278)
	
Else 
	listbox_editCurrentRow("ourBuyRate"; Focus object:C278)
	
End if 

