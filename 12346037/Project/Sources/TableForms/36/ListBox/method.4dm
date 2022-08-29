C_LONGINT:C283(vCount)

If (Form event code:C388=On Load:K2:1)
	disableToolbarButton(1)  // new 
	disableToolbarButton(2)  // edit
End if 

handleListBoxFormMethod(Current form table:C627; ->vCount)
