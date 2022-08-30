C_LONGINT:C283($0)
$0:=0
C_TIME:C306($vTime)
If (isTriggerEnabled)
	
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			setDateTimeUser(->[CashTransactions:36]Date:5; ->$vTime; ->[CashTransactions:36]UserID:6)
			//createRegisterOfCashTrans 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			setDateTimeUserForced(->[CashTransactions:36]Date:5; ->$vTime)
			//createRegisterOfCashTrans 
			
			//: (Trigger event=_o_On Loading Record Event)
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			//deleteRelatedoneRegisters (->[CashTransactions])
	End case 
	
	writeLogTrigger([CashTransactions:36]CashTransactionID:1; $0)
End if 

AUDIT_Trigger
TriggerSync