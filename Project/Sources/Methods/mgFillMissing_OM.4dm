//%attributes = {}
C_OBJECT:C1216($1; $2; $selected)
C_COLLECTION:C1488($find)

$selected:=$1

$find:=Form:C1466.missing.query("formObjName = :1"; $selected.formObjName)

If ($find#Null:C1517)
	If ($find.length>0)
		Form:C1466[$find[0].Name]:=$selected.obj.EnumeratedValue
	End if 
End if 
