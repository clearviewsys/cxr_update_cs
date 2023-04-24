If (Form event code:C388=On Clicked:K2:4)
	If (Self:C308->=True:C214)
		[Wires:8]ReleasedBy:65:=getApplicationUser
	Else 
		[Wires:8]ReleasedBy:65:=Old:C35([Wires:8]ReleasedBy:65)
		
		//Self->:=false
	End if 
End if 