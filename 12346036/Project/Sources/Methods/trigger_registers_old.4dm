//%attributes = {}
C_LONGINT:C283($0)
$0:=0

If (isTriggerEnabled)
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			If (RegisterID="")
				RegisterID:=makeRegisterID
			End if 
			setDateTimeUser(->[Registers:10]CreationDate:14; ->[Registers:10]CreationTime:15)
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			setDateTimeUser(->[Registers:10]ModificationDate:20; ->[Registers:10]ModificationTime:21)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
	
	
	If (([Registers:10]CreditLocal:24=0) & ([Registers:10]DebitLocal:23=0))
		[Registers:10]isTransfer:3:=True:C214
	Else 
		[Registers:10]isTransfer:3:=False:C215
	End if 
	
	[Registers:10]totalFees:30:=calcRegisterTotalFees
	
	RELATE ONE:C42([Registers:10]AccountID:6)
	[Registers:10]isTrade:38:=isThisRegisterATrade
	
	If ([Registers:10]AutoComments:12=True:C214)
		[Registers:10]Comments:9:=makeCommentsForInvoiceLines
	End if 
	writeLogTrigger(RegisterID; $0)
End if 