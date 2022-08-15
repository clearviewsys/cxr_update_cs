//%attributes = {}
// makeDenominationsID (currency; Value)

C_TEXT:C284($0)
C_TEXT:C284($1)  // currency
C_REAL:C285($2)  // denomination Value (ex : 100, 0.25)
If (Count parameters:C259=2)
	$0:=$1+"-"+String:C10($2)
Else 
	$0:=[Denominations:31]Currency:2+"-"+String:C10([Denominations:31]Value:3)
End if 

