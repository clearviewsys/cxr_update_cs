//%attributes = {}
C_POINTER:C301($fieldPtr)
C_TEXT:C284($formObjName)
C_COLLECTION:C1488($find)

If (Form event code:C388=On Data Change:K2:15)
	
	$fieldPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
	$formObjName:=OBJECT Get name:C1087(Object current:K67:2)
	
	$find:=Form:C1466.missing.query("formObjName = :1"; $formObjName)
	
	If ($find#Null:C1517)
		If ($find.length>0)
			Form:C1466[$find[0].Name]:=$fieldPtr->
		End if 
	End if 
	
End if 
