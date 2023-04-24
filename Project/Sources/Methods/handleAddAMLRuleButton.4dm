//%attributes = {}
// handleAddAMLRuleButton (form event)
// on clicked

// #ORDA

C_LONGINT:C283($formEvent; $1)

Case of 
	: (Count parameters:C259=0)
		$formEvent:=On Clicked:K2:4
		
	: (Count parameters:C259=1)
		$formEvent:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Form event code:C388=$formEvent)
	//CONFIRM("Are you sure you want to create a new rule?";"Yes";"No")
	If (OK=1)
		C_OBJECT:C1216($entity; $status)
		$entity:=agg_newRuleEntity
		$status:=$entity.save()
		If ($status.success)
			//[AML_AggrRules]
			Form:C1466.rules:=ds:C1482.AML_AggrRules.all().orderBy("rowNo")
			Form:C1466.rules:=Form:C1466.rules  // refresh the listbox
		Else 
			myAlert("Problem with saving record!")
		End if 
	End if 
End if 