
C_TEXT:C284($Keystroke)

Case of 
	: (Form event code:C388=On Before Keystroke:K2:6)
		$Keystroke:=Keystroke:C390
		
		Case of   // Check to see if a "function" key is hit
			: (($Keystroke="D") | ($keystroke="R"))  // REceived/Buy
				//Self->:=c_Received 
				arrRecPaid{listbox_getSelectedRowNumber(Self:C308)}:=c_Received
				FILTER KEYSTROKE:C389("")
				
			: (($Keystroke="C") | ($keystroke="P"))  // Paid/Sell
				//Self->:=c_Paid 
				arrRecPaid{listbox_getSelectedRowNumber(Self:C308)}:=c_Paid
				FILTER KEYSTROKE:C389("")
			: ($keystroke=Char:C90(Tab key:K12:28))
				
			Else 
				arrRecPaid{listbox_getSelectedRowNumber(Self:C308)}:=""
				
				FILTER KEYSTROKE:C389("")
				
		End case 
		
End case 
