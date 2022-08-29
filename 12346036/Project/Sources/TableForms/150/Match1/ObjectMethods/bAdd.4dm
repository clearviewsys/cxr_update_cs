// #ORDA

If (Form event code:C388=On Clicked:K2:4)
	CONFIRM:C162("Are you sure you want to add a new empty rule?"; "Yes"; "No")
	If (OK=1)
		C_OBJECT:C1216($entity; $status)
		$entity:=ds:C1482.AML_AggrRules.new()
		$entity.UUID:=Generate UUID:C1066
		$entity.ruleName:="New Rule "+String:C10(ds:C1482.AML_AggrRules.all().length+1)
		$entity.isActive:=False:C215
		$entity.thenRequireKYC:=New object:C1471
		$entity.thenRequireKYC.address:=0
		$entity.thenRequireKYC.occupation:=0
		$entity.thenRequireKYC.countryCode:=0
		$entity.thenRequireKYC.nationality:=0
		$entity.thenRequireKYC.citizenship:=0
		$entity.thenRequireKYC.PIN:=0
		$entity.thenRequireKYC.DOB:=0
		$entity.thenRequireKYC.phone:=0
		$entity.thenRequireKYC.cell:=0
		$entity.thenRequireKYC.SIN:=0
		$entity.thenRequireKYC.pictureID:=0
		
		$status:=$entity.save()
		If ($status.success)
			Form:C1466.rules:=ds:C1482.AML_AggrRules.all()
			Form:C1466.rules:=Form:C1466.rules  // refresh the listbox
		End if 
	End if 
End if 
