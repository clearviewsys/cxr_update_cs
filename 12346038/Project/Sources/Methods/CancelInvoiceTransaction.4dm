//%attributes = {}
If (Form event code:C388=On Unload:K2:2)  // User pressed CMD+Period or something
	
	CONFIRM:C162("Shall I save the Invoice before exiting?"; "Yes"; "No")
	If (ok=1)
		// save the invoice 
		
		//validatetransaction
		SAVE RECORD:C53([MESSAGES:11])
	Else 
		//canceltransaction
	End if 
Else   // User pressed the cancel button or close box
	
	
	CONFIRM:C162("Cancelling this invoice will void all transactions."; "Cancel"; "Go Back")
	If (OK=1)
		//canceltransaction
		CANCEL:C270
	Else 
		
		REJECT:C38
	End if 
End if 