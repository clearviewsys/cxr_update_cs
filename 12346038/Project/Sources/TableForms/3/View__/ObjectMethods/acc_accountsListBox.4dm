listbox_displayRecordOnDC(Self:C308; ->[Accounts:9]; ->acc_arrAccountIDs)

If (Form event code:C388=On Data Change:K2:15)
	C_LONGINT:C283($i)
	$i:=listbox_getSelectedRowNumber(Self:C308)
	acc_RecalcAccountListBoxRow($i)
End if 