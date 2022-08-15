C_TEXT:C284(<>COUNTRYCODE)

Case of 
	: (Form event code:C388=On Load:K2:1)
		[Branches:70]CountryCode:12:=<>COUNTRYCODE
		
	: (Form event code:C388=On Data Change:K2:15)
		pickCountryCode(Self:C308)
		//<>COMPANYCOUNTRYCODE:=Self->
End case 