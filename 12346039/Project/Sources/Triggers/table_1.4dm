// Trigger: cheques

C_LONGINT:C283($0)
$0:=0
If (isTriggerEnabled)
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			//[Cheques]autoComment:=makeCommentsCheques 
			//[Cheques]RegisterID:=createRegister ([Cheques]InvoiceID;[Cheques]DueDate;"";"Cheque";[Cheques]isPaid;[Cheques]CustomerID;[Cheques]Amount;[Cheques]Currency;[Cheques]AccountID;->[Cheques];->[Cheques]autoComment)
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			//[Cheques]autoComment:=makeCommentsCheques 
			//[Cheques]RegisterID:=createRegister ([Cheques]InvoiceID;[Cheques]DueDate;[Cheques]RegisterID;"Cheque";[Cheques]isPaid;[Cheques]CustomerID;[Cheques]Amount;[Cheques]Currency;[Cheques]AccountID;->[Cheques];->[Cheques]autoComment)
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			//deleteRelatedManyRegister([Cheques]RegisterID)
	End case 
	writeLogTrigger([Cheques:1]ChequeID:1; $0)
End if 

//TRACE
AUDIT_Trigger
TriggerSync