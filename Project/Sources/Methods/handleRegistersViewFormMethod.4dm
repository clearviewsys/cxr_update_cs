//%attributes = {}
handleViewForm
C_TEXT:C284(vExternalTableName)

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([Customers:3])
	READ ONLY:C145([Invoices:5])
	READ ONLY:C145([Currencies:6])
	REDUCE SELECTION:C351([RegistersAuditTrail:88]; 0)  // no records loaded by default
	
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	
	RELATE ONE:C42([Registers:10]CustomerID:5)  // load customer name
	
	vExternalTableName:=getElegantTableNameByNum([Registers:10]InternalTableNumber:17)
	
	hideObjectsOnTrue([Registers:10]Credit:7>0; "Received@")
	hideObjectsOnTrue([Registers:10]Debit:8>0; "Paid@")
	
	RELATE ONE:C42([Registers:10]InvoiceNumber:10)  //
	
	C_REAL:C285(vOurRateInverse; vSpotRateInverse)
	RELATE ONE:C42([Registers:10]Currency:19)
	vOurRateInverse:=Round:C94(calcSafeDivide(1; [Registers:10]OurRate:25); [Currencies:6]RoundDigit:27)
	vSpotRateInverse:=Round:C94(calcSafeDivide(1; [Registers:10]SpotRate:26); [Currencies:6]RoundDigitInverse:28)
End if 
