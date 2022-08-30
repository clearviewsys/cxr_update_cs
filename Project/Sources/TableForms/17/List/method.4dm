handleListForm
If (Form event code:C388=On Display Detail:K2:22)
	If ([Links:17]CustomerID:14="")
		// _O_OBJECT SET COLOR([Links]CustomerName;calcColour(Red;White))
		OBJECT SET RGB COLORS:C628([Links:17]CustomerName:15; convPalleteColourToRGB(Red:K11:4); convPalleteColourToRGB(White:K11:1))
		
	Else 
		// _O_OBJECT SET COLOR([Links]CustomerName;calcColour(Blue;White))
		OBJECT SET RGB COLORS:C628([Links:17]CustomerName:15; convPalleteColourToRGB(Blue:K11:7); convPalleteColourToRGB(White:K11:1))
		
	End if 
	colourizeAlternateRows([Links:17]isFlagged:32)
	colorizeOnTrue(->[Links:17]CustomerName:15; [Links:17]CustomerID:14#"")
	RELATE ONE:C42([Links:17]CustomerID:14)
End if 
