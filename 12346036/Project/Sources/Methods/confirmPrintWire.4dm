//%attributes = {}
If ((getClientAutoWirePrint) & ([Wires:8]isOutgoingWire:16))  // if we are paying by cheque
	
	CONFIRM:C162("Print the Wire Form?"; "Print"; "Don't Print")
	If (OK=1)
		printThisWire
	End if 
	
End if 