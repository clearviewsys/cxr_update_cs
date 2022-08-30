
Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		[ThirdParties:101]CountryCode:8:=[Countries:62]CountryCode:1
		pickCityStateCountry(->[ThirdParties:101]City:7; ->[ThirdParties:101]theState:29; ->THIRDPARTYCOUNTRYNAME; ->[ThirdParties:101]ZipCode:9)
		[ThirdParties:101]CountryCode:8:=[Countries:62]CountryCode:1
		
End case 

