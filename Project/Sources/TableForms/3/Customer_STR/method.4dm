Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		If ([Customers:3]isCompany:41)
			chkisIndividual:=0
			chkisCompany:=1
		Else 
			chkisIndividual:=1
			chkisCompany:=0
		End if 
		suspiciousNotes:=[Invoices:5]suspiciousNotes:31
		chkLoan:=cab_isTxALoan
		chkDeposit:=cab_isTxADeposit
		chkTransfer:=cab_isTxATransfer
		chkOther:=cab_isOtherTx
		
		If (chkOther)
			otherTxTypeDesc:=""
		End if 
		
End case 