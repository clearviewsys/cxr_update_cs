If (Form event code:C388=On Selection Change:K2:29)
	If (Form:C1466.selectedSource#Null:C1517)
		If (Form:C1466.selectedSource.url#"")
			OPEN URL:C673(Form:C1466.selectedSource.url)
		End if 
	End if 
End if 
