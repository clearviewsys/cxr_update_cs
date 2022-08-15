//%attributes = {}
//This method updates the old Register book to the new one
// in the old database we didn't have the [registers]currency field

ALL RECORDS:C47([Registers:10])
READ WRITE:C146([Registers:10])
FIRST RECORD:C50([Registers:10])
LOAD RECORD:C52([Registers:10])
While (Not:C34(End selection:C36([Registers:10])))
	RELATE ONE:C42([Registers:10]AccountID:6)  // load the associated account
	[Registers:10]Currency:19:=[Accounts:9]Currency:6
	RELATE ONE:C42([Registers:10]InvoiceNumber:10)  // load the associated invoice
	If (Records in selection:C76([Invoices:5])=1)
		If ([Registers:10]Currency:19=<>baseCurrency)
			[Registers:10]OurRate:25:=1
		Else 
			If ([Registers:10]Debit:8>0)
				[Registers:10]OurRate:25:=[Invoices:5]BuyRate:36
			Else 
				[Registers:10]OurRate:25:=[Invoices:5]SellRate:37
			End if 
		End if 
		[Registers:10]DebitLocal:23:=roundToBase([Registers:10]Debit:8*[Registers:10]OurRate:25)
		[Registers:10]CreditLocal:24:=roundToBase([Registers:10]Credit:7*[Registers:10]OurRate:25)
	Else 
		[Registers:10]DebitLocal:23:=0
		[Registers:10]CreditLocal:24:=0
	End if 
	SAVE RECORD:C53([Registers:10])
	NEXT RECORD:C51([Registers:10])
	
End while 
UNLOAD RECORD:C212([Registers:10])
READ ONLY:C145([Registers:10])
myAlert("Update registers done.")