handleDateWidget(Self:C308)
If (Form event code:C388=On Data Change:K2:15)
	If ([Cheques:1]DueDate:3>Current date:C33)  // it's a post dated cheque
		[Cheques:1]chequeStatus:14:=0  // not deposited yet
		
		If ([Cheques:1]isPaid:11)  // cheque received postedated (accounts receivalbe)
			[Cheques:1]AccountID:7:=makeChequeAccountID([Cheques:1]Currency:9)
		Else   // cheque paid postdated (accounts payable)
			[Cheques:1]AccountID:7:=makeChequePayable([Cheques:1]Currency:9)
		End if 
	End if 
	
End if 