handleListBoxFormMethod(Current form table:C627)
Case of 
	: (Form event code:C388=On Load:K2:1)
		disableToolbarButton(1)  // new
		disableToolbarButton(2)  // edit
		disableToolbarButton(3)  // delete
End case 