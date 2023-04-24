//%attributes = {}
C_LONGINT:C283($found)
//SET QUERY DESTINATION(Into variable; $found)
selectDenomination([CashTransactions:36]Currency:4; vDenomination)
//SET QUERY DESTINATION(Into current selection)


If (Records in selection:C76([Denominations:31])=0)
	myAlert("This denomination is not defined in the system.")
	//_O_OBJECT SET COLOR(vDenomination;calcColour(White;Red))
	OBJECT SET RGB COLORS:C628(vDenomination; convPalleteColourToRGB(White:K11:1); convPalleteColourToRGB(Red:K11:4))
	
Else 
	
	// _O_OBJECT SET COLOR(vDenomination;calcColour(Black;White))
	OBJECT SET RGB COLORS:C628(vDenomination; convPalleteColourToRGB(Black:K11:16); convPalleteColourToRGB(White:K11:1))
	
End if 


