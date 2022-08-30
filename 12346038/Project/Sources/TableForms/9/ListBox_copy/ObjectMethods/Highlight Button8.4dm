If (isUserAuthorizedToDelete(->[Accounts:9]))
	CREATE SET:C116([Accounts:9]; "original")
	listbox_QueryRecordFromRows(->acc_accountsListBox; ->[Accounts:9]; ->[Accounts:9]AccountID:1; ->acc_arrAccountIDs)
	If (Records in selection:C76([Accounts:9])>0)
		CONFIRM:C162("Are you sure you want to delete the selection?"; "Cancel"; "Delete")
		If (Ok=0)
			READ WRITE:C146([Accounts:9])
			deleteRecordsUsingSet(->[Accounts:9]; "original")
			POST OUTSIDE CALL:C329(Current process:C322)
			READ ONLY:C145([Accounts:9])
		Else 
			USE SET:C118("original")
		End if 
	End if 
	CLEAR SET:C117("original")
Else 
	ALERT:C41("Sorry, you are not authorized to delete any subledger accounts.")
End if 