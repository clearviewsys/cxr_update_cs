handleListForm
If (Form event code:C388=On Display Detail:K2:22)
	If ([eWires:13]priority:36=2)
		// _O_OBJECT SET COLOR([eWires]Subject;calcColour(Red;Light grey))
		OBJECT SET RGB COLORS:C628([eWires:13]Subject:6; convPalleteColourToRGB(Red:K11:4); convPalleteColourToRGB(Light grey:K11:13))
		
	Else 
		// _O_OBJECT SET COLOR([eWires]Subject;calcColour(Dark grey;White))
		OBJECT SET RGB COLORS:C628([eWires:13]Subject:6; convPalleteColourToRGB(Dark grey:K11:12); convPalleteColourToRGB(White:K11:1))
		
	End if 
	colourizeAlternateRows([eWires:13]isFlagged:27)
	hideObjectsOnTrue(Not:C34([eWires:13]isFlagged:27); "Flag")
	
End if 