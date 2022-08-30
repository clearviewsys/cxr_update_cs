Self:C308->:=Uppercase:C13(Self:C308->)
If (selectCityStatesByZipCode(Self:C308->)>0)
	If (Records in selection:C76([Cities:60])>0)
		[Customers:3]City:8:=[Cities:60]CityName:1
	End if 
	If (Records in selection:C76([States:61])>0)
		[Customers:3]Province:9:=[Cities:60]StateCode:2
	End if 
	If (Records in selection:C76([Countries:62])>0)
		[Customers:3]Country_obs:11:=[Countries:62]CountryName:2
	End if 
Else 
	BEEP:C151
End if 
