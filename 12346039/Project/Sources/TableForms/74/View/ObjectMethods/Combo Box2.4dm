If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrFieldConstraints; 0)
	QUERY:C277([FieldConstraints:69]; [FieldConstraints:69]isConditional:7=True:C214)  // find all field constraints that are conditional
	DISTINCT VALUES:C339([FieldConstraints:69]GroupName:8; arrFieldConstraints)  // delete the dupplicates
	SORT ARRAY:C229(arrFieldConstraints)
	
End if 

If (Form event code:C388=On Clicked:K2:4)
	[AMLRules:74]thenRequireFieldConstraintGroup:23:=arrFieldConstraints{arrFieldConstraints}
End if 