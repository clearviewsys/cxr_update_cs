//%attributes = {}
If (Is Windows:C1573)
	CANCEL:C270
Else 
	If (Form:C1466.transaction.transactionType="Send")
		If (Form:C1466.valueObject#Null:C1517)
			// prevent crash on macOS when closing a dialog with WebArea after all steps are done in Send transaction
			// crashes on High Sierra, Mojave and Catalina
			HIDE PROCESS:C324(Current process:C322)
			PAUSE PROCESS:C319(Current process:C322)
		Else 
			// crash happens only when we have the result, so it is safe to cancel here and end process
			CANCEL:C270
		End if 
	Else 
		CANCEL:C270
	End if 
End if 
