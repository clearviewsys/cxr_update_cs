C_TEXT:C284($Keystroke)

Case of 
	: (Form event code:C388=On Before Keystroke:K2:6)
		$Keystroke:=Keystroke:C390
		
		Case of   // Check to see if a "function" key is hit
			: (($Keystroke="R") | ($keystroke="B"))  // REceived/Buy
				
				Self:C308->:="Received"
				
			: (($Keystroke="P") | ($keystroke="S"))  // REceived/Buy
				Self:C308->:="Paid"
				
			Else 
				Self:C308->:=""
				
		End case 
End case 


FILTER KEYSTROKE:C389("")
POST KEY:C465(Tab:K15:37)


