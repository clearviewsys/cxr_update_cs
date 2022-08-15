C_LONGINT:C283($foreground; $background)
$background:=White:K11:1

If (Form event code:C388=On Display Detail:K2:22)
	Case of 
		: ([Invoices:5]TransactionType:12="Buy")
			//Color:=–($foreground+(256 * $background)) 
			$foreground:=Blue:K11:7
			// _O_OBJECT SET COLOR([Invoices]TransactionType;($foreground+(256*$background)))
			OBJECT SET RGB COLORS:C628([Invoices:5]TransactionType:12; convPalleteColourToRGB($foreground); convPalleteColourToRGB($background))
			
		: ([Invoices:5]TransactionType:12="Sell")
			$foreground:=Red:K11:4
			// _O_OBJECT SET COLOR([Invoices]TransactionType;($foreground+(256*$background)))
			OBJECT SET RGB COLORS:C628([Invoices:5]TransactionType:12; convPalleteColourToRGB($foreground); convPalleteColourToRGB($background))
			
		: ([Invoices:5]TransactionType:12="")
			$foreground:=White:K11:1
			// _O_OBJECT SET COLOR([Invoices]TransactionType;($foreground+(256*$background)))
			OBJECT SET RGB COLORS:C628([Invoices:5]TransactionType:12; convPalleteColourToRGB($foreground); convPalleteColourToRGB($background))
			
	End case 
End if 