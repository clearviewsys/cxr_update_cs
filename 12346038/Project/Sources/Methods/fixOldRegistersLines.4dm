//%attributes = {}
C_TEXT:C284($type)
$type:=getTransactionTypeString([Invoices:5]fromCurrency:3; [Invoices:5]toCurrency:8; False:C215)
READ WRITE:C146([Registers:10])

Case of 
	: ($type="Buy")
		C_LONGINT:C283($i)
		//relateManyRegisters 
		FIRST RECORD:C50([Registers:10])
		For ($i; 1; Records in selection:C76([Registers:10]))
			LOAD RECORD:C52([Registers:10])
			If ([Registers:10]Currency:19=<>basecurrency)  // CAD
				[Registers:10]OurRate:25:=1
				[Registers:10]DebitLocal:23:=0
				[Registers:10]CreditLocal:24:=[Registers:10]Credit:7
			Else 
				[Registers:10]OurRate:25:=[Invoices:5]toAmount:26/[Invoices:5]fromAmount:25
				[Registers:10]DebitLocal:23:=[Invoices:5]toAmount:26
				[Registers:10]CreditLocal:24:=0
			End if 
			SAVE RECORD:C53([Registers:10])
			NEXT RECORD:C51([Registers:10])
		End for 
		//UNLOAD RECORD([Registers])
	: ($type="Sell")
		FIRST RECORD:C50([Registers:10])
		For ($i; 1; Records in selection:C76([Registers:10]))
			LOAD RECORD:C52([Registers:10])
			If ([Registers:10]Currency:19=<>basecurrency)  // CAD
				[Registers:10]OurRate:25:=1
				[Registers:10]DebitLocal:23:=[Registers:10]Debit:8
				[Registers:10]CreditLocal:24:=0
			Else 
				[Registers:10]OurRate:25:=[Invoices:5]fromAmount:25/[Invoices:5]toAmount:26
				[Registers:10]DebitLocal:23:=0
				[Registers:10]CreditLocal:24:=[Invoices:5]fromAmount:25
			End if 
			SAVE RECORD:C53([Registers:10])
			NEXT RECORD:C51([Registers:10])
		End for 
	: ($type="Cross")
		[Invoices:5]isFlagged:41:=True:C214
		
		FIRST RECORD:C50([Registers:10])
		For ($i; 1; Records in selection:C76([Registers:10]))
			LOAD RECORD:C52([Registers:10])
			If ([Registers:10]Debit:8>0)  // buy
				[Registers:10]OurRate:25:=[Invoices:5]PolicyRateBuy:5
				[Registers:10]DebitLocal:23:=roundToBase([Registers:10]Debit:8*[Registers:10]OurRate:25)
				[Registers:10]CreditLocal:24:=0
			Else   // sell
				[Registers:10]OurRate:25:=[Invoices:5]PolicyRateSell:10
				[Registers:10]DebitLocal:23:=0
				[Registers:10]CreditLocal:24:=roundToBase([Registers:10]Credit:7*[Registers:10]OurRate:25)
			End if 
			SAVE RECORD:C53([Registers:10])
			NEXT RECORD:C51([Registers:10])
		End for 
		
	: ($type="-")
		FIRST RECORD:C50([Registers:10])
		For ($i; 1; Records in selection:C76([Registers:10]))
			LOAD RECORD:C52([Registers:10])
			[Registers:10]OurRate:25:=1
			[Registers:10]DebitLocal:23:=[Registers:10]Debit:8
			[Registers:10]CreditLocal:24:=[Registers:10]Credit:7
			
			SAVE RECORD:C53([Registers:10])
			NEXT RECORD:C51([Registers:10])
		End for 
	Else 
		FIRST RECORD:C50([Registers:10])
		For ($i; 1; Records in selection:C76([Registers:10]))
			LOAD RECORD:C52([Registers:10])
			[Registers:10]OurRate:25:=0
			[Registers:10]DebitLocal:23:=0
			[Registers:10]CreditLocal:24:=0
			SAVE RECORD:C53([Registers:10])
			NEXT RECORD:C51([Registers:10])
		End for 
End case 
READ ONLY:C145([Registers:10])
