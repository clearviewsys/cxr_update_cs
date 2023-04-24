If (Form event code:C388=On Selection Change:K2:29)
	If (Form:C1466.entity#Null:C1517)
		Form:C1466.entityData.setValues(Form:C1466.entity.properties)
	Else 
		Form:C1466.entityData.setValues(New collection:C1472)
	End if 
End if 