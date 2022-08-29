//%attributes = {}
C_TEXT:C284($1; $countryName)
C_TEXT:C284($0)

Case of 
		
	: (Count parameters:C259=1)
		$countryName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 
READ ONLY:C145([Countries:62])
QUERY:C277([Countries:62]; [Countries:62]CountryName:2=$countryName)
$0:=[Countries:62]CountryCode:1
REDUCE SELECTION:C351([Countries:62]; 0)
