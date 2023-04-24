C_TEXT:C284($msg)
C_POINTER:C301($popupPtr)
C_OBJECT:C1216($result)
C_LONGINT:C283($countryID)

$popupPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "popupCities")

If (Form:C1466.destinationCountry#"")
	
	If (Form:C1466.city#"")
		
		$countryID:=mgCountryCode2CountryID(Form:C1466.destinationCountry)
		
		$result:=mgGetCityByCountry($countryID; Form:C1466.city; Form:C1466.stateCode)
		
		If ($result#Null:C1517)
			
			If ($result.success)
				
				Form:C1466.cities:=$result.result
				
				If (Form:C1466.cities#Null:C1517)
					
					COLLECTION TO ARRAY:C1562(Form:C1466.cities; $popupPtr->; "City")
					
					If (Size of array:C274($popupPtr->)>0)
						$popupPtr->:=1
					End if 
					
				Else 
					
					ARRAY TEXT:C222($popupPtr->; 0)
					
					myAlert("No cities found ...")
					
				End if 
				
			Else 
				
				$msg:=mgGetSOAPErrorDetails($result.mgerrormsg)
				
				myAlert($msg)
				
			End if 
			
		End if 
		
	Else 
		
		myAlert("Type first few letters of city name.")
		
	End if 
	
Else 
	
	myAlert("Please choose country first.")
	
End if 
