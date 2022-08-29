//%attributes = {}
C_TEXT:C284($1; $currencyCode)
C_OBJECT:C1216($2; $lookupTable)
C_BOOLEAN:C305($0)
C_COLLECTION:C1488($c)
C_LONGINT:C283($found)

$currencyCode:=$1
$0:=False:C215

If (Count parameters:C259>1)
	$lookupTable:=$2
Else 
	$lookupTable:=mgGetCurrencies
End if 

If ($lookupTable#Null:C1517)
	
	If (True:C214)
		
		ARRAY TEXT:C222($propertyNames; 0)
		
		OB GET PROPERTY NAMES:C1232($lookupTable; $propertyNames)
		
		$found:=Find in array:C230($propertyNames; mgCurrencyID2CurrencyCode(Num:C11($currencyCode)))
		
		If ($found#-1)
			$0:=True:C214
		End if 
		
	Else 
		// OB Keys is available in v18 R3 and later only
		//$c:=OB Keys($lookupTable)
		
		$c:=objKeys($lookupTable)
		
		$found:=$c.indexOf($currencyCode)
		
		If ($found#-1)
			$0:=True:C214
		End if 
		
	End if 
	
End if 
