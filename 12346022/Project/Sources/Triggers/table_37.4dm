C_LONGINT:C283($0)
$0:=0

If (isTriggerEnabled)
	Case of 
			
		: (Trigger event:C369=On Saving New Record Event:K3:1)  // Save new record
			//[AccountInOuts]autoComment:=makeCommentsAccountInOuts 
			
			//[AccountInOuts]RegisterID:=createRegister ([AccountInOuts]InvoiceID;[AccountInOuts]Date;"";"Acc. Transfer";[AccountInOuts]isPaid;[AccountInOuts]CustomerID;[AccountInOuts]Amount;[AccountInOuts]Currency;[AccountInOuts]AccountID;->[AccountInOuts];->[AccountInOuts]autoComment)
			[AccountInOuts:37]UserID:11:=getApplicationUser
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)  // modify record    
			//[AccountInOuts]autoComment:=makeCommentsAccountInOuts 
			//[AccountInOuts]RegisterID:=createRegister ([AccountInOuts]InvoiceID;[AccountInOuts]Date;[AccountInOuts]RegisterID;"Acc. Transfer";[AccountInOuts]isPaid;[AccountInOuts]CustomerID;[AccountInOuts]Amount;[AccountInOuts]Currency;[AccountInOuts]AccountID;->[AccountInOuts];->[AccountInOuts]autoComment)
			//[AccountInOuts]:=getApplicationUser
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			//deleteRelatedoneRegisters (->[accountinouts])
	End case 
	
	writeLogTrigger([AccountInOuts:37]AccountInOutID:1; $0)
End if 

AUDIT_Trigger
TriggerSync