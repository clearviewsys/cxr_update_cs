//%attributes = {}
//titleCase (->field/var)

If (Form event code:C388=On Data Change:K2:15)
	C_POINTER:C301($1)
	$1->:=toTitleCase($1)
End if 