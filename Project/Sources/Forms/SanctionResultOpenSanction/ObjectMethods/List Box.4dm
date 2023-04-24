Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		If (Form:C1466.result#Null:C1517)
			Form:C1466.data.setValues(Form:C1466.result.properties)
		Else 
			Form:C1466.data.setValues(New collection:C1472)
		End if 
End case 