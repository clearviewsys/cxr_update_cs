If (Form event code:C388=On Load:K2:1)
	LIST TO ARRAY:C288("keyValue_keylist"; Self:C308->)
End if 

If (Form event code:C388=On Clicked:K2:4)
	[KeyValues:115]Key:2:=Self:C308->{Self:C308->}
	OBJECT SET TITLE:C194(*; "Description"; getKeyValueDescription(Self:C308->{Self:C308->}))
End if 
