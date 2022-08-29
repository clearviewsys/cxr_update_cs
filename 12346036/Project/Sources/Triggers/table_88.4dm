C_LONGINT:C283($0)

$0:=0  //Assume the database request will be granted
If (isTriggerEnabled)
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			
			[RegistersAuditTrail:88]TriggerDate:48:=Current date:C33
			[RegistersAuditTrail:88]TriggerTime:59:=Current time:C178
			[RegistersAuditTrail:88]triggerUser:60:=getApplicationUser  //ibb 
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			//[BankAccounts]Balance:=[BankAccounts]TotalDeposits-[BankAccounts]TotalWithdrawal
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
	End case 
	//writeLogTrigger ([;$0)
End if 


AUDIT_Trigger