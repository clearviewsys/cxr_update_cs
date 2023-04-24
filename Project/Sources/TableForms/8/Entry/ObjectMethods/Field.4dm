If (Form event code:C388=On Clicked:K2:4)
	If (Self:C308->=True:C214)
		[Wires:8]verfifiedBy:63:=getApplicationUser
	Else 
		[Wires:8]verfifiedBy:63:=Old:C35([Wires:8]verfifiedBy:63)
		
		//Self->:=""
	End if 
End if 