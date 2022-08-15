If (Form event code:C388=On Load:K2:1)
	OBJECT SET TITLE:C194(Self:C308->; "Display "+getElegantTableName(Current form table:C627))
End if 
If (Form event code:C388=On Clicked:K2:4)
	displayList(Current form table:C627)
End if 