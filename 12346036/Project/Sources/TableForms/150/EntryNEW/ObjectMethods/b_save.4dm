If (Form event code:C388=On Clicked:K2:4)
	If (Form:C1466.Rule#Null:C1517)
		CONFIRM:C162("Are you sure you want to save the rule?"; "Yes"; "No")
		If (OK=1)
			Form:C1466.Rule.save()
		Else 
			Form:C1466.Rule.reload()
		End if 
	End if 
End if 