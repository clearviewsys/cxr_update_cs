//%attributes = {}
// handleAutoClearoutCheque  -> boolean
// returns true if cheque could be cleared automatically (i.e there is one main bank account to clear the cheque)
// PRE: the cheque record must be selected before it can be cleared

If ([Cheques:1]DueDate:3<=(Current date:C33+1))  // due in a day
	READ ONLY:C145([Accounts:9])
	
	QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=[Cheques:1]Currency:9; *)
	QUERY:C277([Accounts:9];  & ; [Accounts:9]isBankAccount:7=True:C214)
	
	If (Records in selection:C76([Accounts:9])=1)  // there's only one bank of that currency
		READ WRITE:C146([Cheques:1])
		LOAD RECORD:C52([Cheques:1])
		setChequeStatus(1; [Accounts:9]AccountID:1)
		SAVE RECORD:C53([Cheques:1])
		createRegisterOfCheques  // not sure about this line ******
		
		$0:=True:C214
		//READ ONLY([Cheques])` I commented this because it affects the modify form behavior if called by a button
	Else   // there's either no bank or more banks to deposit the cheque into
		$0:=False:C215
	End if 
	
Else   // cheque is still not due
	$0:=False:C215
End if 