
If ([Confirmations:153]confirmedReason:11="")
	myAlert("Please document the reason for this denial.")
	REJECT:C38
Else 
	confirmationSetStatus([Confirmations:153]confirmationID:2; confirmationDeny; getSystemUserName; [Confirmations:153]confirmedReason:11)
	
	CANCEL:C270
End if 