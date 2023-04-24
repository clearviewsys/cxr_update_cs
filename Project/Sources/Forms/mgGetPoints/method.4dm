C_POINTER:C301($popupPtr)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET ENABLED:C1123(*; "btn_pickCities"; False:C215)
		
		Form:C1466.cities:=New collection:C1472
		$popupPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "popupCities")
		ARRAY TEXT:C222($popupPtr->; 0)
		$popupPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "popupStates")
		ARRAY TEXT:C222($popupPtr->; 0)
		
		mgFillCountryName("#destinationCountryName"; Form:C1466.destinationCountry; Form:C1466.countries; "#destinationCountry")
		Form:C1466.destinationCountryID:=mgCountryCode2CountryID(Form:C1466.destinationCountry)
		
		mgGetPointsStates_OM
		
End case 
