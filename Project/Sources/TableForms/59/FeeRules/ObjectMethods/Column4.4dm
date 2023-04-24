C_TEXT:C284($Keystroke)

C_LONGINT:C283($row)
Case of 
	: (Form event code:C388=On Before Keystroke:K2:6)
		$Keystroke:=Keystroke:C390
		$row:=listbox_getSelectedRowNumber(Self:C308)
		Case of   // Check to see if a "function" key is hit
			: ($keystroke="C")
				arrMethod{$row}:=c_Cash
				FILTER KEYSTROKE:C389("")
				
			: ($keystroke="A")
				arrMethod{$row}:=c_Account
				FILTER KEYSTROKE:C389("")
				
			: ($keystroke="H")
				arrMethod{$row}:=c_Cheque
				FILTER KEYSTROKE:C389("")
				
			: ($keystroke="W")
				arrMethod{$row}:=c_Wire
				FILTER KEYSTROKE:C389("")
				
			: ($keystroke="E")
				arrMethod{$row}:=c_eWire
				FILTER KEYSTROKE:C389("")
				
			: ($keystroke=Char:C90(Tab key:K12:28))
				
			Else 
				arrMethod{$row}:=""
				FILTER KEYSTROKE:C389("")
				
		End case 
		
End case 
