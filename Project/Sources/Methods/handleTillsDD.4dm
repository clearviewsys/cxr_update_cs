//%attributes = {}
#DECLARE($tillsPtr : Pointer)
// tillsPtr should be a pointer to a pull down menu object
// call this method from within Invoices.listbox form objects
// e.g. handleTillsPullDown (self)
// PRE: the On Load and On Clicked event should be checked in order for the code to work
// POST: Current Selection of [CashRegisters] and [invoices] and [registers] will be changed

If ($tillsPtr#Null:C1517)
	
	If (Form event code:C388=On Load:K2:1)
		ALL RECORDS:C47([CashRegisters:33])
		SELECTION TO ARRAY:C260([CashRegisters:33]CashRegisterID:1; $tillsPtr->)
		INSERT IN ARRAY:C227($tillsPtr->; 1)
		$tillsPtr->{1}:="Tills"
		$tillsPtr->:=1  // select the first element of the pull down by default
		
	End if 
	
	If (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($till)
		$till:=$tillsPtr->{$tillsPtr->}
		selectRegistersByTillNo($till)
		
		// map the registers to the insvoice
		RELATE MANY SELECTION:C340([Registers:10]InvoiceNumber:10)
	End if 
	
End if 