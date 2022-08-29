C_LONGINT:C283(vCount)

handleListBoxFormMethod(Current form table:C627; ->vCount)

Case of 
	: (Form event code:C388=On Load:K2:1)
		disableToolbarButton(1)  // new 
		disableToolbarButton(2)  // edit
	Else 
		
End case 