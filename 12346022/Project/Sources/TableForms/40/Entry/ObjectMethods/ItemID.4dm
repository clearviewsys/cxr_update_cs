UNLOAD RECORD:C212([Items:39])

applyFocusRect
If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Getting Focus:K2:7))
	pickItems(->[ItemInOuts:40]ItemID:2)
	If (OK=1)
		setItemInOutFieldsInEntryForm
	End if 
	
End if 

If (Form event code:C388=On Data Change:K2:15)
	If (Records in selection:C76([Items:39])=1)
		GOTO OBJECT:C206(*; "Qty")
	Else 
		BEEP:C151
	End if 
End if 