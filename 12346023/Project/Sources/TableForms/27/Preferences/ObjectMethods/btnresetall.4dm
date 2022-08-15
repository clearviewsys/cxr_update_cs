C_LONGINT:C283($iSeqNo)

myConfirm("Reset ALL table sequence numbers?")

If (OK=1)
	UTIL_resetSequenceNums
	
	If (Get database parameter:C643([eWires:13]; Table sequence number:K37:31)>10000)
		[ServerPrefs:27]starteWireNumber:3:=1
	End if 
	
	If (Get database parameter:C643([Invoices:5]; Table sequence number:K37:31)>10000)
		[ServerPrefs:27]startInvoiceNumber:1:=1
	End if 
	
	If (Get database parameter:C643([Registers:10]; Table sequence number:K37:31)>10000)
		[ServerPrefs:27]startRegisterNumber:2:=1
	End if 
	
End if 