pickCountry(Self:C308)
[Customers:3]PictureID_CountryCode:118:=[Countries:62]CountryCode:1

Case of 
	: ([Countries:62]RiskLevel:5=2)
		myAlert("AML Warning: This country is considered medium risk.")
	: ([Countries:62]RiskLevel:5=3)
		myAlert("AML Warning: This country is high risk!")
		
End case 