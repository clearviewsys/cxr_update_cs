If (<>DOREMEMBERWINDOWPOSITIONS)
	//handleListboxColumnsSettings(Self; ->[Accounts])  // keep the column settings
End if 

//listbox_displayRecordOnDC (Self;->[Accounts];->acc_arrAccountIDs)
// replaced the above line with the below code @tiran Sep 30/2020
If (Form event code:C388=On Double Clicked:K2:5)
	C_LONGINT:C283($row)
	C_TEXT:C284($accountID)
	
	$row:=listbox_getSelectedRowNumber(Self:C308)
	$accountID:=arrAccountIDs{$row}
	//displayRecordID (table(->[Accounts]);acc_arrAccountIDs{$row};true) // old method
	If ($accountID#"")
		QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$accountID)
		displayCurrentRecord(->[Accounts:9]; isUserAllowedToViewThisAccount)
	End if 
	
End if 
