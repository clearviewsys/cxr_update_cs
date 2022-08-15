//%attributes = {}
C_REAL:C285(vAmountReceived; vAmountPaid)
C_TEXT:C284(vChequeStatus)
C_DATE:C307(CHQvDueDepositDate)


If ([Cheques:1]Amount:8>0)
	handlePaidReceivedDisplayDetail([Cheques:1]Amount:8; [Cheques:1]isPaid:11; ->vAmountReceived; ->vAmountPaid)
	vChequeStatus:=getChequeStatusString([Cheques:1]chequeStatus:14)
	If ([Cheques:1]DepositDate:17#nullDate)
		CHQvDueDepositDate:=[Cheques:1]DepositDate:17
	Else 
		CHQvDueDepositDate:=[Cheques:1]DueDate:3
	End if 
	
Else 
	vAmountReceived:=0
	vAmountPaid:=0
	vChequeStatus:=""
End if 