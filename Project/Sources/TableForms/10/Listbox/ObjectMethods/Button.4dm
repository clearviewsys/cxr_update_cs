If (isUserDesigner)
	myConfirm("Are you sure you want to unreconcile all reconciled rows?")
	If (OK=1)
		disableTriggers
		READ WRITE:C146([Registers:10])
		USE SET:C118("$registers_LBSet")
		APPLY TO SELECTION:C70([Registers:10]; [Registers:10]isValidated:35:=False:C215)
		READ ONLY:C145([Registers:10])
		enableTriggers
	End if 
End if 
