//%attributes = {}
// this method is called from the Registers table trigger (on save, on modify)


[Registers:10]UnrealizedGain:56:=CalcUnrealizedGain
[Registers:10]totalFees:30:=calcRegisterTotalFees
RELATE ONE:C42([Registers:10]AccountID:6)
[Registers:10]isTrade:38:=isThisRegisterATrade
[Registers:10]isCash:40:=[Accounts:9]isCashAccount:3

If ([Registers:10]baseCURR:60="")
	[Registers:10]baseCURR:60:=<>BASECURRENCY
End if 

If ([Registers:10]AutoComments:12=True:C214)
	[Registers:10]Comments:9:=makeCommentsForInvoiceLines
End if 

If ([Registers:10]metaData:66=Null:C1517)
	[Registers:10]metaData:66:=New object:C1471
End if 

If ([Registers:10]metaData:66.sourceOfFund=Null:C1517)
	[Registers:10]metaData:66.sourceOfFund:=""
End if 

If ([Registers:10]metaData:66.purposeOfTransaction=Null:C1517)
	[Registers:10]metaData:66.purposeOfTransaction:=""
End if 

If ([Registers:10]metaData:66.typeOfTransaction=Null:C1517)
	[Registers:10]metaData:66.typeOfTransaction:=""
End if 

If (getKeyValue("registers.valuedate.match.invoice"; "false")="true")
	C_OBJECT:C1216($entity)
	$entity:=ds:C1482.Invoices.query("InvoiceID == :1"; [Registers:10]InvoiceNumber:10)
	If ($entity.length=1)
		[Registers:10]RegisterDate:2:=$entity.first().invoiceDate
	End if 
End if 