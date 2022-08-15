//%attributes = {}
// returns two letter CXR country code based on three letter MoneyGram country code

C_TEXT:C284($1; $cc3)
C_COLLECTION:C1488($2; $countries; $found)

$cc3:=$1

If (Count parameters:C259<2)
	$countries:=mgGetCountryCodes
Else 
	$countries:=$2
End if 

If ($countries#Null:C1517)
	
	$found:=$countries.query("alpha3 = :1"; Lowercase:C14($cc3))
	
	If ($found.length>0)
		
		$0:=Uppercase:C13($found[0].alpha2)
		
	End if 
	
End if 
