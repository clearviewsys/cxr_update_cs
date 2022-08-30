// Jan 17, 2012 00:33:56 -- I.Barclay Berry 
//GET PICTURE FROM LIBRARY("_"+Table name(Current form table);Self->)
If (Form event code:C388=On Load:K2:1)
	handleModuleIcon(Current form table:C627; Self:C308)
End if 

If (Form event code:C388=On Clicked:K2:4)
	CANCEL:C270
End if 
