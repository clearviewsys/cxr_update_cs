C_LONGINT:C283(cbQuerySelection)
If (cbQuerySelection=1)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterType:4="buy")
Else 
	QUERY:C277([Registers:10]; [Registers:10]RegisterType:4="buy")
End if 
QUERY SELECTION:C341([Registers:10]; [Registers:10]isTransfer:3=False:C215)
QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19#<>baseCurrency)
orderByRegisters
reg_fillRegistersListBox