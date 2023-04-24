If (Form event code:C388=On Data Change:K2:15)
	C_POINTER:C301($ptr)
	$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "countryName")
	
	$ptr->:=getCountryNameByCode(Form:C1466.CountryCode)
End if 