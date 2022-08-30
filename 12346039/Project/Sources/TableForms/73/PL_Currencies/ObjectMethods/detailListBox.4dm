C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)

handleListboxColumnsSettings(Self:C308; ->[Reports:73]; "PL_Currencies"; "detailListBox")

If (Form event code:C388=On Double Clicked:K2:5)
	$ColumnPtr:=Focus object:C278
	// $Column contains a pointer to col2
	$Row:=$ColumnPtr->  //$Row 
	READ ONLY:C145([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=arrRegisterIDs{$row})
	handledoubleclickevent(->[Registers:10])
End if 
