//%attributes = {}
C_LONGINT:C283($1; $currencyID; $i)
C_OBJECT:C1216($2; $currencies)
C_TEXT:C284($0)

$currencyID:=$1
$0:=""

ARRAY TEXT:C222($properties; 0)

If (Count parameters:C259<2)
	$currencies:=mgGetCurrencies
Else 
	$currencies:=$2
End if 

If ($currencies#Null:C1517)
	
	OB GET PROPERTY NAMES:C1232($currencies; $properties)
	
	For ($i; 1; Size of array:C274($properties))
		If ($currencies[$properties{$i}].id#Null:C1517)
			If ($currencies[$properties{$i}].id=String:C10($currencyID; "000"))
				$0:=$properties{$i}
				$i:=Size of array:C274($properties)+1
			End if 
		End if 
	End for 
	
End if 
