//%attributes = {}
C_TEXT:C284(env_FullContactName; env_recepientAddress; env_CompanyAddress; env_CompanyPhone; vMainPhone)
C_TEXT:C284(VDateTime; vMachineAlias; vComments)

If (Form event code:C388=On Header:K2:17)
	If ([Invoices:5]eWireID:23#"")
		RELATE ONE:C42([Invoices:5]eWireID:23)
		RELATE ONE:C42([eWires:13]LinkID:8)
	Else 
		UNLOAD RECORD:C212([eWires:13])
		UNLOAD RECORD:C212([Links:17])
	End if 
	hideObjectsOnTrue(([Invoices:5]ThirdPartyName:29=""); "onbehalfof@")
	hideObjectsOnTrue(([Invoices:5]printRemarks:16=""); "comments@")
	showObjectOnTrue([Invoices:5]isCancelled:84; "CANCELLED@")
	
	setInvoiceVarsToFields
	env_recepientAddress:=env_makeAddressText([Customers:3]Address:7; [Customers:3]City:8; [Customers:3]Province:9; [Customers:3]PostalCode:10; [Customers:3]Country_obs:11)
	env_CompanyAddress:=getBranchFullAddress
	env_CompanyPhone:=getBranchPhone
	handlePhoneField(->env_CompanyPhone)
	
	RELATE ONE:C42([Invoices:5]TransactionTypeID:91)
	
	
	vMainPhone:=CUST_getMainPhone
	makeCommentsBooking
	
	If (getDefaultLanguage=1)  // french
		vDateTime:="Imprimé le "+String:C10(Current date:C33; "long")+" à "+String:C10(Current time:C178)
	Else   // english otherwise ; better be a case if
		vDateTime:="Printed on "+String:C10(Current date:C33)+" @ "+String:C10(Current time:C178)  // english
	End if 
	
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	C_REAL:C285(vAmount; vInverseRate; vTax1; vTax2; vAmountLocal; vTotalFees)
	C_TEXT:C284(vBuySell; vComments)
	QUERY:C277([Currencies:6]; [Currencies:6]ISO4217:31=[Registers:10]Currency:19)
	
	If ([Invoices:5]isTransfer:42)
		If ([Registers:10]Debit:8>0)
			vBuySell:=getLocalizedString("Transferred to")+" "+[Registers:10]AccountID:6
		Else 
			vBuySell:=getLocalizedString("Transferred from")+" "+[Registers:10]AccountID:6
		End if 
	Else 
		C_TEXT:C284($Transaction)
		
		If ([Registers:10]Debit:8>0)
			If ([Registers:10]Currency:19=<>baseCurrency)
				vBuySell:=getLocalizedString("Received from customer")
			Else 
				vBuySell:=getLocalizedString("Bought from customer")
			End if 
		Else 
			If ([Registers:10]Currency:19=<>baseCurrency)
				vBuySell:=getLocalizedString("Paid to customer")
			Else 
				vBuySell:=getLocalizedString("Sold to customer")
			End if 
		End if 
	End if 
	vAmount:=[Registers:10]Debit:8-[Registers:10]Credit:7
	vInverseRate:=calcSafeDivide(1; [Registers:10]OurRate:25)
	vTax1:=[Registers:10]tax1_Received:31-[Registers:10]tax1_Paid:33
	vTax2:=[Registers:10]tax2_Received:32-[Registers:10]tax2_Paid:34
	vAmountLocal:=[Registers:10]DebitLocal:23-[Registers:10]CreditLocal:24
	vPercentFeeLocal:=[Registers:10]totalFees:30-[Registers:10]feeLocal:29
	vComments:=[Registers:10]Comments:9
	
	declaration:=getKeyValue("email.configuration.booking.declaration")
	settlement:=getKeyValue("email.configuration.booking.settlement")
	
	
	hideObjectsOnTrue((vTax1+vTax2=0); "tax@")  // hide all tax fields if tax is zero
	//hideObjectsOnTrue (([Registers]externalTableNumber=Table(->[CashTransactions]));"comments")
	hideObjectsOnTrue(([Registers:10]totalFees:30=0); "fee@")
	hideObjectsOnTrue(([Registers:10]Currency:19=<>baseCurrency); "hifl_@")
	
End if 

If (Form event code:C388=On Printing Break:K2:19)
	showObjectOnTrue([Invoices:5]isCancelled:84; "CANCELLED@")
	
	
	//hideObjectsOnTrue ((vRemainReceive=0) & (vRemainPaid=0);"offBalance@")
End if 

If (Form event code:C388=On Printing Footer:K2:20)
	showObjectOnTrue([Invoices:5]isCancelled:84; "CANCELLED@")
	
End if 