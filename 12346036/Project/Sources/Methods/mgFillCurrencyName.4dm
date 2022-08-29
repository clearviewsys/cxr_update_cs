//%attributes = {}
C_TEXT:C284($1; $formObjectName)
C_TEXT:C284($2; $currencyCode)
C_OBJECT:C1216($3; $currencies)
C_POINTER:C301($formObj)
C_LONGINT:C283($found)

$formObjectName:=$1
$currencyCode:=$2

$formObj:=OBJECT Get pointer:C1124(Object named:K67:5; $formObjectName)

If (Count parameters:C259<3)
	$currencies:=mgGetCurrencies
Else 
	$currencies:=$3
End if 

If ($currencies#Null:C1517)
	
	ARRAY TEXT:C222($propertyNames; 0)
	
	OB GET PROPERTY NAMES:C1232($currencies; $propertyNames)
	
	$found:=Find in array:C230($propertyNames; $currencyCode)
	
	If ($found#-1)
		$formObj->:=Uppercase:C13($currencies[$propertyNames{$found}].name)
	End if 
	
End if 

