//([items];"PICK")
applyFocusRect
If (Form event code:C388=On Clicked:K2:4)
	pickItems(->[ItemInOuts:40]ItemID:2; True:C214)
	If (OK=1)
		setItemInOutFieldsInEntryForm
	End if 
End if 