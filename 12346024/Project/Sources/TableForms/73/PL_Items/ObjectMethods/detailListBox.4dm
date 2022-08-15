C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)

If (Form event code:C388=On Double Clicked:K2:5)
	$ColumnPtr:=Focus object:C278
	$Row:=$ColumnPtr->
	If ($Row#1)  //first row is opening balance; no detail view needed
		QUERY:C277([ItemInOuts:40]; [ItemInOuts:40]ItemInOutID:1=arrItemInOutIds{$row})
		handledoubleclickevent(->[ItemInOuts:40])
	End if 
End if 
