
If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrTills; 0)
	ALL RECORDS:C47([CashRegisters:33])
	SELECTION TO ARRAY:C260([CashRegisters:33]CashRegisterID:1; arrTills)
	INSERT IN ARRAY:C227(arrTills; 1)
	arrTills{1}:="Tills"
	arrTills:=1
	
End if 

If (Form event code:C388=On Clicked:K2:4)
	C_TEXT:C284($till)
	$till:=arrTills{arrTills}
	selectRegistersByTillNo($till)
	
	// map the registers to the insvoice
	RELATE MANY SELECTION:C340([Registers:10]InvoiceNumber:10)
End if 