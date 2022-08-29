//%attributes = {}
C_LONGINT:C283($1; $countryID)
C_COLLECTION:C1488($2; $countries; $found)

$countryID:=$1
$0:=""

If (Count parameters:C259<2)
	$countries:=mgGetCountryCodes
Else 
	$countries:=$2
End if 

If ($countries#Null:C1517)
	
	$found:=$countries.query("id = :1"; $countryID)
	
	If ($found.length>0)
		$0:=Uppercase:C13($found[0].alpha3)
	End if 
	
End if 
