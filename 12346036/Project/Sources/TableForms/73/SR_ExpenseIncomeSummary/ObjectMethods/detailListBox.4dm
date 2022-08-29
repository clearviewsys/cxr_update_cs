C_LONGINT:C283($formEvent; $row)
C_POINTER:C301($ColumnPtr)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Double Clicked:K2:5)
		$ColumnPtr:=Focus object:C278
		$row:=$ColumnPtr->
		If (($row>0) & (arrRegisterID{$row}#"") & (arrRegisterID{$row}#"Subtotal"))
			listbox_displayRecordOnDC(Self:C308; ->[Registers:10]; ->arrRegisterID)
		End if 
End case 