var $status : Object

If (Form event code:C388=On Clicked:K2:4)
	If (Form:C1466.Rule#Null:C1517)
		CONFIRM:C162("Are you sure you want to save the rule?"; "Yes"; "No")
		If (OK=1)
			$status:=Form:C1466.Rule.save()
			
			If ($status.success=True:C214)
				Form:C1466.rules:=ds:C1482.AML_AggrRules.all().orderBy("rowNo")
				Form:C1466.rules:=Form:C1466.rules  // refresh the listbox
			Else 
				myAlert("Rule was not saved successfully!")
			End if 
		Else 
			Form:C1466.Rule.reload()
		End if 
	End if 
End if 