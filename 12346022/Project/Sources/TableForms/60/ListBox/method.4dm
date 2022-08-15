//If ((Form event=On Display Detail) | (Form event=On Printing Detail))
//RELATE ONE([Cities]StateCode)
//RELATE ONE([Cities]CountryCode)
//End if 
//
C_LONGINT:C283(mainListBox)
C_LONGINT:C283(vCount)

handleListBoxFormMethod(Current form table:C627; ->vCount)
If (Form event code:C388=On Load:K2:1)
	SET FIELD RELATION:C919([Cities:60]StateCode:2; Automatic:K51:4; Manual:K51:3)
End if 

If (Form event code:C388=On Unload:K2:2)
	SET FIELD RELATION:C919([Cities:60]StateCode:2; Manual:K51:3; Manual:K51:3)
End if 