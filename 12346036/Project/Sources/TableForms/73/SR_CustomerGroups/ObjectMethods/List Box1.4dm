//C_LONGINT($row)
//C_POINTER($columnPtr)
//
//If (Form event=On Double Clicked)
//$ColumnPtr:=Focus object
//  // $Column contains a pointer to col2
//$Row:=$ColumnPtr->  //$Row equals 5
//QUERY([Customers];[Customers]GroupName=arrCustGroups{$row})
//handledoubleclickevent 
//End if 

//LISTBOX GET CELL POSITION 
If (Form event code:C388=On Double Clicked:K2:5)
	handleHoldingsListBox(->[Customers:3]; ->[Customers:3]GroupName:90; ->arrCustGroups)
End if 