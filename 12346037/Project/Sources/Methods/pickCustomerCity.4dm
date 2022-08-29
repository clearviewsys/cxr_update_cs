//%attributes = {}
// pickCustomerCity ({form event})
// e.g. pickCustomerCity (on clicked)

C_LONGINT:C283($formEvent)

Case of 
	: (Count parameters:C259=0)
		$formEvent:=On Data Change:K2:15
	: (Count parameters:C259=1)
		$formEvent:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Form event code:C388=$formEvent)
	pickCityStateCountry(->[Customers:3]City:8; ->[Customers:3]Province:9; ->[Customers:3]CountryCode:113; ->[Customers:3]Country_obs:11)
End if 