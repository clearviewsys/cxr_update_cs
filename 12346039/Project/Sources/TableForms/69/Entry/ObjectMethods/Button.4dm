
C_BOOLEAN:C305(FC_Condition)

If ([FieldConstraints:69]condition:14="")
Else 
	EXECUTE FORMULA:C63("FC_Condition:="+[FieldConstraints:69]condition:14)
	
	
	If (FC_Condition)
		ALERT:C41("Resolves to TRUE")
	Else 
		ALERT:C41("Resolves to FALSE")
	End if 
	
End if 