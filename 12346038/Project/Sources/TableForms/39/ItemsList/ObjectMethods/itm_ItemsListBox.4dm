listbox_displayRecordOnDC(Self:C308; ->[Items:39]; ->ARRITEMIDS)
If (Form event code:C388=On Data Change:K2:15)
	C_LONGINT:C283($i)
	$i:=listbox_getSelectedRowNumber(Focus object:C278)
	acc_RecalcAccountListBoxRow($i)
End if 