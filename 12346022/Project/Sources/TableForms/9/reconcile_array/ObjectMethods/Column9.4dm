//If (Form event=On Clicked )
//C_POINTER($columnPtr)
//C_LONGINT($row)
//$ColumnPtr:=Focus object
//  ` $Column contains a pointer to col2
//$Row:=$ColumnPtr->  `$Row equals 5
//If (arrChecked{$row})
//EDIT ITEM(arrValidation;$row)
//HIGHLIGHT TEXT(arrValidation{$row};0;100)
//End if 
//
//End if 

If (Form event code:C388=On Data Change:K2:15)
	setListBoxFocusedRow(->arrValidator; -><>applicationUser)
	arrChecked{getListBoxRowNumber}:=True:C214
End if 