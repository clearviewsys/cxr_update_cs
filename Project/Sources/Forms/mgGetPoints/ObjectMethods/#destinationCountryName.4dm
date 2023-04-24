C_TEXT:C284($chosen)

pickCountry(->$chosen)

Form:C1466.destinationCountry:=[Countries:62]CountryCode:1
Form:C1466.destinationCountryID:=mgCountryCode2CountryID(Form:C1466.destinationCountry)

mgFillCountryName("#destinationCountryName"; Form:C1466.destinationCountry; Form:C1466.countries; "#destinationCountry")

mgGetPointsStates_OM