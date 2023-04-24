//%attributes = {}
C_REAL:C285(vAmount)

LOAD RECORD:C52([Registers:10])  // lock this record

RELATE ONE:C42([Registers:10]InvoiceNumber:10)
RELATE ONE:C42([Registers:10]CustomerID:5)
vAmount:=[Registers:10]Credit:7
If ((getRegisterTypeEnum([Registers:10]RegisterType:4)>1) & ([Registers:10]isReceived:13=False:C215))  // cheque or wired paid as 
	
	CONFIRM:C162("Do you want to print the cheque for this register?"; "Print Cheque"; "Don't Print Cheque")
	If (OK=1)
		//OUTPUT FORM([Registers];"printCheque")
		
		//LOAD RECORD([Registers])  ` lock this record
		
		//RELATE ONE([Registers]InvoiceNumber)
		
		//RELATE ONE([Registers]CustomerID)
		
		//PRINT RECORD([Registers])
		
		//UNLOAD RECORD([Registers])  ` unlock this record
		
		C_LONGINT:C283($winRef)
		$winRef:=Open form window:C675([Registers:10]; "Cheque"; Plain fixed size window:K34:6; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40([Registers:10]; "Cheque")
		CLOSE WINDOW:C154($winRef)
	End if 
End if 

UNLOAD RECORD:C212([Registers:10])  // unlock this record