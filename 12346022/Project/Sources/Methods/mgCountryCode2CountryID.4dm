//%attributes = {}
// returns country ID based on country code
// it accepts both two- or three- letter country code
// you can pass collection of countries if you have one already in memory

C_TEXT:C284($1; $countryCode)
C_COLLECTION:C1488($2; $countries; $found)
C_LONGINT:C283($0)

$countryCode:=$1
$0:=0  // return this if nothing found

If (Count parameters:C259<2)
	$countries:=mgGetCountryCodes
Else 
	$countries:=$2
End if 

If ($countries#Null:C1517)
	
	If (Length:C16($countryCode)=2)
		$found:=$countries.query("alpha2 = :1"; Lowercase:C14($countryCode))
	Else 
		$found:=$countries.query("alpha3 = :1"; Lowercase:C14($countryCode))
	End if 
	
	If ($found.length>0)
		$0:=$found[0].id
	End if 
	
End if 
