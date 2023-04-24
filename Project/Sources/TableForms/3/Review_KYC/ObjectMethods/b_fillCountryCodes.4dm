If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($code; $name)
	$code:=<>COUNTRYCODE
	$name:=getCountryNameByCode($code)
	
	[Customers:3]CountryOfBirthCode:18:=$code
	[Customers:3]Nationality:91:=$name
	[Customers:3]CountryOfResidenceCode:114:=$code
	[Customers:3]CountryOfResidence_obs:61:=$name
	[Customers:3]CitizenshipCountryCode:22:=$code
	[Customers:3]Citizenship_obs:60:=$name
	
End if 
