C_TEXT:C284(vSearchText)

If (Form event code:C388=On Load:K2:1)
	OBJECT SET TITLE:C194(Self:C308->; <>COUNTRYCODE)
End if 

If (Form event code:C388=On Clicked:K2:4)
	QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=<>COUNTRYCODE)
	vSearchText:=<>COUNTRYCODE
	handlePickCountryButton
End if 