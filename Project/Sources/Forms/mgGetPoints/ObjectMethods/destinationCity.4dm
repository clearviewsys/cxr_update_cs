If (Form event code:C388=On Data Change:K2:15)
	
	If (Form:C1466.city#"")
		OBJECT SET ENABLED:C1123(*; "btn_pickCities"; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(*; "btn_pickCities"; False:C215)
	End if 
	
End if 
