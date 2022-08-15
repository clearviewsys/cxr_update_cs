If (Form event code:C388=On Load:K2:1)
	allRecordsCashRegisters
	SELECTION TO ARRAY:C260([CashRegisters:33]CashRegisterID:1; arrTillNo)
	
	If (Records in selection:C76([CashRegisters:33])=1)
		arrTillNo:=1
		FIRST RECORD:C50([CashRegisters:33])
	Else 
		UNLOAD RECORD:C212([CashRegisters:33])
	End if 
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (arrTillNo>0)
		queryByID(->[CashRegisters:33]; arrTillNo{arrTillNo})
	End if 
End if 