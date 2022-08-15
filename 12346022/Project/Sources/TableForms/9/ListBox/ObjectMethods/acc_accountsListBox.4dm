If (<>DOREMEMBERWINDOWPOSITIONS)
	handleListboxColumnsSettings(Self:C308; ->[Accounts:9])  // keep the column settings
End if 

//listbox_displayRecordOnDC (Self;->[Accounts];->acc_arrAccountIDs)
// replaced the above line with the below code @tiran Sep 30/2020
If (Form event code:C388=On Double Clicked:K2:5)
	C_LONGINT:C283($row)
	C_TEXT:C284($accountID)
	
	$row:=listbox_getSelectedRowNumber(Self:C308)
	$accountID:=acc_arrAccountIDs{$row}
	//displayRecordID (table(->[Accounts]);acc_arrAccountIDs{$row};true) // old method
	If ($accountID#"")
		QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$accountID)
		displayCurrentRecord(->[Accounts:9]; isUserAllowedToViewThisAccount)
	End if 
	
End if 

If (Form event code:C388=On Data Change:K2:15)
	C_LONGINT:C283($i)
	$i:=listbox_getSelectedRowNumber(Self:C308)
	acc_RecalcAccountListBoxRow($i)
End if 




If (Form event code:C388=On Expand:K2:41)
	If (Macintosh command down:C546)
		LISTBOX EXPAND:C1100(*; "acc_accountsListBox"; False:C215; lk all:K53:16)
	End if 
End if 

If (Form event code:C388=On Collapse:K2:42)
	If (Macintosh command down:C546)
		LISTBOX COLLAPSE:C1101(*; "acc_accountsListBox"; False:C215; lk all:K53:16)
	End if 
End if 