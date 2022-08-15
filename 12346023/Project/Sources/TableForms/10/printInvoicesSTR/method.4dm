C_REAL:C285(vTotalReceived; vTotalPaid; vRemainReceive; vRemainPaid; vSumDebitLC; vSumCreditLC; vSumFees)

If (Form event code:C388=On Header:K2:17)
	RELATE ONE:C42([Registers:10]CustomerID:5)
	RELATE ONE:C42([Registers:10]InvoiceNumber:10)
	hideObjectsOnTrue(([Invoices:5]ThirdPartyName:29=""); "onbehalfof")
	hideObjectsOnTrue(([Invoices:5]ModificationDate:17=!00-00-00!); "modify@")
	//hideObjectsOnTrue (([Invoices]printRemarks="");"comments@")
	setInvoiceVarsToFields
End if 

If (Form event code:C388=On Printing Break:K2:19)
	vTotalReceived:=Subtotal:C97([Registers:10]Debit:8)
	vTotalPaid:=Subtotal:C97([Registers:10]Credit:7)
	vSumDebitLC:=Subtotal:C97([Registers:10]DebitLocal:23)
	vSumCreditLC:=Subtotal:C97([Registers:10]CreditLocal:24)
	vSumFees:=Subtotal:C97([Registers:10]totalFees:30)
	
	vRemainReceive:=[Invoices:5]fromAmount:25-vTotalReceived
	vRemainPaid:=[Invoices:5]toAmount:26-vTotalPaid
	hideObjectsOnTrue((vRemainReceive=0) & (vRemainPaid=0); "offBalance@")
	
End if 