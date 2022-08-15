//%attributes = {}
// IdentityMind_TOMtoIRR($amount)
// Convert the amount from TOM to IRR
// 
// Parameters:
// $amount (C_REAL)
//     the amount in TOM
// 
// Return: (C_REAL)
//      the amount in IRR

C_REAL:C285($1; $amount)
C_REAL:C285($0; $converted)
Case of 
	: (Count parameters:C259=1)
		$amount:=$1
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 
$converted:=$amount*10
$0:=$converted