//%attributes = {}
// returns three letter country code based on two letter country code we are using in CXR

C_TEXT:C284($1; $cxrCountryCode)
C_COLLECTION:C1488($2; $countries; $found)

$cxrCountryCode:=$1

If (Count parameters:C259<2)
	$countries:=mgGetCountryCodes
Else 
	$countries:=$2
End if 

If ($countries#Null:C1517)
	
	$found:=$countries.query("alpha2 = :1"; Lowercase:C14($cxrCountryCode))
	
	If ($found.length>0)
		
		$0:=Uppercase:C13($found[0].alpha3)
		
	End if 
	
End if 
