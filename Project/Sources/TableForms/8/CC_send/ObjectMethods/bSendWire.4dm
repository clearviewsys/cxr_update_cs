C_LONGINT:C283($chosenLine; $ret)
C_TEXT:C284($chosenValue)
C_BOOLEAN:C305($priority)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (drop_CCwireSend>0)
			
			$chosenLine:=drop_CCwireSend
			$chosenValue:=Substring:C12(drop_CCwireSend{$chosenLine}; 0; 3)
			$priority:=(bPriority=1)
			
			If ($chosenValue#"Loa")  //First 3 letters of "Loading accounts"
				$ret:=CC_createAndSendPayment([Wires:8]CXR_WireID:1; $chosenValue; $priority)
			Else 
				myAlert("Accounts Loading, please wait")
			End if 
			If ($ret=200)
				CANCEL:C270
			End if 
		Else 
			myAlert("Please select an account")
		End if 
End case 