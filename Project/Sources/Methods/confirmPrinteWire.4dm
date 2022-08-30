//%attributes = {}

C_BOOLEAN:C305($0)

If ((getClientAutoeWirePrint) & ([eWires:13]isPaymentSent:20))  // if we are paying by eWire
	
	CONFIRM:C162("Print the eWire Form?"; "Print"; "Don't Print")
	If (OK=1)
		printThiseWire
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
	
Else 
	$0:=False:C215
End if 