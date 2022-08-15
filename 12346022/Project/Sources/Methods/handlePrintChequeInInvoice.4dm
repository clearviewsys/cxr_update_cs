//%attributes = {}
If (vPaymentType="Paid")
	
	C_LONGINT:C283($winRef)
	$winRef:=Open form window:C675([Registers:10]; "Cheque"; Plain dialog box:K34:4; Horizontally centered:K39:1; Vertically centered:K39:4)
	//LOAD RECORD([Registers])
	
	DIALOG:C40([Registers:10]; "Cheque")
	//CLOSE WINDOW
	
	//UNLOAD RECORD([Registers])
	
Else 
	myAlert("You can only print a payable cheque.")
End if 