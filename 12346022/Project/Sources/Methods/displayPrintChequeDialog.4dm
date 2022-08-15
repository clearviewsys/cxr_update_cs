//%attributes = {"shared":true}
If ([Cheques:1]isPaid:11)  // if we are paying by cheque
	READ ONLY:C145([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=[Cheques:1]RegisterID:6)
	C_REAL:C285(vAmount)
	C_TEXT:C284(vCustomerName; vComments)
	C_DATE:C307(vDueDate)
	
	vComments:="Invoice# "+[Cheques:1]InvoiceID:5+". "+[Cheques:1]Memo:10
	vCustomerName:=[Cheques:1]PayTo:15
	vAmount:=[Cheques:1]Amount:8
	vDueDate:=[Cheques:1]DueDate:3
	openFormWindow(->[Registers:10]; "Cheque")
	CLOSE WINDOW:C154
End if 