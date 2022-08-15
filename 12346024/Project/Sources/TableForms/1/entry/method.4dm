//handleChequeTransactionFormMeth(true)
C_TEXT:C284(vChequeStatus)

If (Form event code:C388=On Load:K2:1)
	initInvoiceVars
	colourizeField(->[Cheques:1]Amount:8)
	colourizeField(->[Cheques:1]Currency:9)
	colourizeField(->[Cheques:1]PayTo:15)
	colourizeField(->[Cheques:1]AccountID:7)
	
End if 

If (onNewRecordEvent)
	[Cheques:1]ChequeID:1:=makechequesID
	[Cheques:1]InvoiceID:5:="---"
	[Cheques:1]IssueDate:16:=Current date:C33
	[Cheques:1]DueDate:3:=Current date:C33
End if 

RELATE ONE:C42([Cheques:1]CustomerID:2)
vChequeStatus:=getChequeStatusString([Cheques:1]chequeStatus:14)

If (Form event code:C388=On Outside Call:K2:11)  // this for the apply and next, before buttons
	If ([Cheques:1]Currency:9#"")
		selectBankAccountsOfCurrency([Cheques:1]Currency:9)
		SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; arrBankAccounts)
	End if 
End if 