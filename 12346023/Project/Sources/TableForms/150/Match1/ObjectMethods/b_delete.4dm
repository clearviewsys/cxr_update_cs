If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to delete the selected rows?"; "Yes"; "No")
	If (OK=1)
		C_OBJECT:C1216($notDropped)
		If (Form:C1466.selectedRules.length>0)
			$notDropped:=Form:C1466.selectedRules.drop()  // $notDropped is an entity selection containing all the not dropped entities
			If ($notDropped.length=0)  //The delete action is successful, all the entities have been deleted
				ALERT:C41("Deletion successful!")  //The dropped entity selection remains in memory
				Form:C1466.rules:=ds:C1482.AML_AggrRules.all()
				Form:C1466.rules:=Form:C1466.rules  // refresh the listbox
			Else 
				ALERT:C41("Problem during drop, try later! Some records were locked")
			End if 
		End if 
	End if 
End if 