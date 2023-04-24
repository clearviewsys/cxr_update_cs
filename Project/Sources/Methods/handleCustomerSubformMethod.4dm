//%attributes = {}
//handleCustomerSubformMethod (->[subformTABLE] ; {->flagField})

// call this method from the subform inside [Customers]View 
// EVENTS: on Display Detail, on Load, On double Click, On Click, On open Detail

C_POINTER:C301($tablePtr; $1)
C_POINTER:C301($flagFieldPtr; $2)

$tablePtr:=$1

Case of 
	: (Count parameters:C259=2)
		$flagFieldPtr:=$2
End case 

If (Form event code:C388=On Display Detail:K2:22)
	If (Is nil pointer:C315($flagFieldPtr))
		colourizeAlternateRows
	Else 
		colourizeAlternateRows($flagFieldPtr->)
	End if 
End if 

If (Form event code:C388=On Double Clicked:K2:5)
	handledoubleclickevent
End if 
