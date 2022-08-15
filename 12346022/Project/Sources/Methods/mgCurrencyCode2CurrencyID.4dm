//%attributes = {}
// returns currency ID based on currency code
// you can pass object containing currencies as defined in our currencies.json file

C_TEXT:C284($1; $currencyCode)
C_OBJECT:C1216($2; $currencies)
C_LONGINT:C283($0)

$currencyCode:=$1
$0:=0  // return this if nothing found

If (Count parameters:C259<2)
	$currencies:=mgGetCurrencies
Else 
	$currencies:=$2
End if 

If ($currencies#Null:C1517)
	If ($currencies[$currencyCode]#Null:C1517)
		If ($currencies[$currencyCode].id#Null:C1517)
			$0:=Num:C11($currencies[$currencyCode].id)  // id is text in JSON
		End if 
	End if 
End if 
