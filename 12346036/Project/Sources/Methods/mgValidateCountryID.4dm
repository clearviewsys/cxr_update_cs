//%attributes = {}
C_TEXT:C284($1; $countryCode)
C_COLLECTION:C1488($2; $lookupTable; $c)
C_BOOLEAN:C305($0)

$countryCode:=$1
$0:=False:C215

If (Count parameters:C259>1)
	$lookupTable:=$2
Else 
	$lookupTable:=mgGetCountryCodes
End if 

If ($lookupTable#Null:C1517)
	
	$c:=$lookupTable.query("id = :1"; Num:C11($countryCode))
	
	If ($c.length>0)
		$0:=True:C214
	End if 
	
End if 
