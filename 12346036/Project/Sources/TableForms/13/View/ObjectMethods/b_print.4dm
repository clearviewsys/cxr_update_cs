

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Is new record:C668([Invoices:5]))
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		
	Else 
		printThiseWire
End case 