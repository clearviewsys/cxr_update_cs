C_POINTER:C301($popupPtr)

$popupPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "popupCities")

If (Form event code:C388=On Data Change:K2:15)
	
	If ($popupPtr->>0)
		Form:C1466.city:=$popupPtr->{$popupPtr->}
	End if 
	
End if 
