//%attributes = {}
// createPrimaryBankAccount ({currency})

C_TEXT:C284($1; $curr; $primaryBankAccount)


If (Count parameters:C259=0)
	$curr:=<>baseCurrency
Else 
	$curr:=$1
End if 

$primaryBankAccount:=makeWireTemplateID($curr)
createAccount($primaryBankAccount; c_Banks; $curr; False:C215; False:C215)