If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to add a rule?"; "Yes"; "No")
	If (OK=1)
		C_OBJECT:C1216($entity)
		$entity:=ds:C1482.AML_AggrRules.new()
		
		$entity.fromObject(Form:C1466.Rule)
		$entity.ruleName:=Request:C163("Rule Name")
		$entity.UUID:=Generate UUID:C1066  // to generate a new one
		$entity._SYNC_ID:=""  // to prevent duplication
		checkInit
		C_TEXT:C284($ruleName)
		
		$ruleName:=Form:C1466.Rule.ruleName
		checkIfNullString(->$ruleName; "Rule Name")
		
		If (isValidationConfirmed)
			$entity.save()
			Form:C1466.rules:=ds:C1482.AML_AggrRules.all()  // refresh the screen
			Form:C1466.rules:=Form:C1466.rules
		End if 
	Else 
		Form:C1466.Rule.reload()
	End if 
End if 