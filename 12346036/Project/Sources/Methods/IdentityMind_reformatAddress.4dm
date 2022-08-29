//%attributes = {}
// IdentityMind_reformatAddress($address)
// Remove the appartment number
//
// Parameters:
// $address (C_TEXT) 
//     the address with or without the appartment number
//
// Return:
//    the address without the appartment number

C_TEXT:C284($0)  // address without unit number
C_TEXT:C284($1; $address)
$0:=""

Case of 
	: (Count parameters:C259=1)
		$address:=$1
		$0:=$address
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 

If (Match regex:C1019("^[0-9]+\\-[0-9]+.*$"; $address))
	C_REAL:C285($position)
	$position:=Position:C15("-"; $address)+1
	$address:=Substring:C12($address; $position)
	$0:=$address
End if 