If ([eWires:13]toCountry:10="")
	BEEP:C151
	GOTO OBJECT:C206([eWires:13]toCountry:10)
Else 
	pickAgentForCountry(Self:C308; [eWires:13]toCountry:10)
End if 
